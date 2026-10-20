# Scripts

Operational Bash scripts are stored in the `scripts/` directory.

## start-all.sh

Main post-reboot startup workflow.

It:

```text
unlocks encrypted storage
starts Immich safely
starts Vaultwarden
starts Paperless-ngx
starts Homepage
starts Uptime Kuma
shows container status
```

## start-immich.sh

Starts:

```text
immich_postgres
immich_redis
immich_machine_learning
```

It waits until PostgreSQL and Redis are healthy before starting:

```text
immich_server
```

This avoids the PostgreSQL startup race seen during earlier reboots.

## backup-immich.sh

Runs the rsync backup from the primary encrypted drive to the backup drive.

Before starting, it checks:

```bash
mountpoint -q /mnt/immichvault
mountpoint -q /mnt/backupvault
```

Backup results are written to:

```text
~/backup.log
```

## network-monitor.sh

Reserved for commands and logging used during network troubleshooting.

Only sanitized versions of scripts are stored in the public repository.
