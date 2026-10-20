# Storage and Backups

## Primary Storage

The main external HDD is encrypted with LUKS.

```text
Device: /dev/sda1
Mapper: immichvault
Mount point: /mnt/immichvault
```

Main data stored on the drive:

```text
/mnt/immichvault/immich/
/mnt/immichvault/apps/vaultwarden/
/mnt/immichvault/apps/paperless/
```

The drive is manually unlocked after reboot.

```bash
sudo cryptsetup open /dev/sda1 immichvault
sudo mount /dev/mapper/immichvault /mnt/immichvault
```

A helper script is also installed:

```bash
unlock-immich
```

Check the mount:

```bash
mountpoint /mnt/immichvault
df -h /mnt/immichvault
```

## Backup Storage

A second encrypted HDD is used for backups.

```text
Device: /dev/sdb1
Mapper: backupvault
Mount point: /mnt/backupvault
Backup directory: /mnt/backupvault/immich-backup
```

Unlock and mount:

```bash
sudo cryptsetup open /dev/sdb1 backupvault
sudo mount /dev/mapper/backupvault /mnt/backupvault
```

## Backup Script

Backups use `rsync`.

The main options are:

```bash
rsync -aHAX --delete
```

The script checks that both drives are mounted before copying data:

```bash
mountpoint -q /mnt/immichvault
mountpoint -q /mnt/backupvault
```

The live Immich PostgreSQL directory is excluded:

```text
immich/postgres/
```

Immich-generated SQL backups stored elsewhere under the Immich directory remain included.

## Schedule

The backup runs through a systemd timer.

Check the timer:

```bash
systemctl status backup-immich.timer
```

Run the backup manually:

```bash
sudo /home/<USER>/backup-immich.sh
```

Check the log:

```bash
tail -20 ~/backup.log
```

## Backup Limitation

This is an rsync backup, not RAID or versioned backup storage.

Because `--delete` is used, deleted files can also be removed from the backup during the next successful sync.
