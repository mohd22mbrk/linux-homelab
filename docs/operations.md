# Operations

## Normal Startup After Reboot

Encrypted storage must be unlocked before storage-dependent services are started.

Main startup command:

```bash
~/start-all.sh
```

The script:

```text
1. Unlocks and mounts encrypted storage
2. Starts Immich dependencies
3. Waits for PostgreSQL and Redis
4. Starts Immich
5. Starts the remaining homelab services
6. Displays container status
```

## Container Status

```bash
docker ps
```

Short status view:

```bash
docker ps --format 'table {{.Names}}\t{{.Status}}'
```

## Homelab Compose

```bash
cd ~/homelab
docker compose ps
```

Start:

```bash
docker compose up -d
```

Stop:

```bash
docker compose down
```

## Storage

Check primary storage:

```bash
mountpoint /mnt/immichvault
df -h /mnt/immichvault
```

Check backup storage:

```bash
mountpoint /mnt/backupvault
df -h /mnt/backupvault
```

## Immich

Safe startup:

```bash
~/start-immich.sh
```

Server logs:

```bash
docker logs immich_server
```

Database logs:

```bash
docker logs immich_postgres
```

## Backup

Unlock backup drive:

```bash
sudo cryptsetup open /dev/sdb1 backupvault
sudo mount /dev/mapper/backupvault /mnt/backupvault
```

Run backup:

```bash
sudo /home/<USER>/backup-immich.sh
```

Check result:

```bash
tail -20 ~/backup.log
```

## Monitoring

```text
Homepage:     3000
Uptime Kuma:  3001
Netdata:      19999
```

## OctoPrint

Check for printer:

```bash
ls -l /dev/ttyUSB* /dev/ttyACM*
```

Start OctoPrint:

```bash
docker start octoprint
```
