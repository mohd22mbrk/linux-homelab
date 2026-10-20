# Linux Homelab

A self-hosted Linux homelab built on a Lenovo ThinkCentre M710q running Ubuntu Server. The environment is used for hands-on practice with Linux administration, Docker, networking, cybersecurity, encrypted storage, monitoring, backups and automation.

The server runs a mixture of containerized and host-level services, with remote access provided through Tailscale.

## Current Stack

| Service | Purpose |
|---|---|
| Immich | Self-hosted photo and video management |
| Pi-hole | Network-wide DNS filtering |
| Vaultwarden | Self-hosted password management |
| Paperless-ngx | Document management and OCR |
| Homepage | Central service dashboard |
| Uptime Kuma | Service availability monitoring |
| Netdata | Host and container performance monitoring |
| OctoPrint | Remote 3D printer management |
| Tailscale | Secure remote access |
| SSH | Server administration |

Most application services are deployed using Docker or Docker Compose.

## Storage

Persistent data for sensitive services is stored on LUKS-encrypted external storage.

The primary encrypted drive contains:

- Immich media and database data
- Vaultwarden data
- Paperless-ngx documents and application data

A second LUKS-encrypted drive is used for scheduled backups.

Backups are performed using `rsync` and a systemd timer, with checks in place to prevent a backup from running if the required encrypted volumes are not mounted.

## Security

The homelab uses several layers of protection:

- LUKS encryption for application data
- Tailscale for private remote access
- HTTPS access to Vaultwarden through Tailscale Serve
- Vaultwarden account registration disabled
- Manual encrypted-storage unlock after reboot
- Services dependent on encrypted storage prevented from automatically starting before the storage is mounted
- Separate backup storage
- Sensitive files excluded from Git using `.gitignore`

Credentials, environment files, encryption keys, private addresses and other sensitive values are not stored in this repository.

## Automation

Custom Bash scripts are used for common administrative tasks, including:

- unlocking encrypted storage
- starting storage-dependent services
- waiting for service dependencies to become healthy
- starting the homelab stack
- running and validating backups
- network troubleshooting and monitoring

Relevant sanitized scripts are included in the [`scripts/`](scripts/) directory.

## Documentation

Detailed documentation is available under [`docs/`](docs/):

- [Architecture](docs/architecture.md)
- [Services](docs/services.md)
- [Networking](docs/networking.md)
- [Storage and Backups](docs/storage-backups.md)
- [Security](docs/security.md)
- [Operations](docs/operations.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Scripts](docs/scripts.md)
- [Changelog](docs/changelog.md)

## Project Goals

This homelab is used to build practical experience with:

- Linux server administration
- Docker and container management
- networking and DNS
- secure remote access
- system monitoring
- encrypted storage
- backup and recovery
- Bash automation
- troubleshooting and incident analysis

The environment is continuously expanded as new services and infrastructure changes are tested.
