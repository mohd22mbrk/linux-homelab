# Changelog

## 2026

### Initial Server Setup

- Installed Ubuntu Server on Lenovo ThinkCentre M710q
- Installed Docker
- Added SSH administration
- Added Tailscale
- Added Pi-hole
- Added Wake-on-LAN
- Added OctoPrint

### Storage and Immich

- Added LUKS-encrypted primary storage
- Added Immich
- Added second encrypted HDD
- Added rsync backup script
- Added weekly systemd backup timer

### Monitoring

- Added Homepage
- Added Uptime Kuma
- Added Netdata

### Password and Document Management

- Added Vaultwarden
- Added Paperless-ngx
- Moved persistent application data to encrypted storage
- Restricted Vaultwarden to localhost
- Added HTTPS access through Tailscale Serve
- Disabled Vaultwarden public signups

### Reliability

- Disabled automatic startup for encrypted-storage-dependent containers
- Added encrypted-storage mount checks
- Added `unlock-immich`
- Added `start-immich.sh`
- Added `start-all.sh`
- Added PostgreSQL health waiting
- Added backup mount protection
- Updated Immich after exit-code-139 crashes
