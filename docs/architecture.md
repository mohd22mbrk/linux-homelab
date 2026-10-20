# Architecture

## Host

- Lenovo ThinkCentre M710q
- Ubuntu Server 24.04 LTS
- Docker
- Docker Compose
- Ethernet connection
- Headless administration through SSH

## Layout

```text
Ubuntu Server
│
├── Host Services
│   ├── SSH
│   ├── Tailscale
│   └── Wake-on-LAN
│
├── Docker
│   ├── Pi-hole
│   ├── Immich
│   ├── Vaultwarden
│   ├── Paperless-ngx
│   ├── Homepage
│   ├── Uptime Kuma
│   ├── Netdata
│   └── OctoPrint
│
├── Primary LUKS Storage
│   ├── Immich
│   ├── Vaultwarden
│   └── Paperless-ngx
│
└── Backup LUKS Storage
    └── rsync backup
