# Services

## Pi-hole

Network-wide DNS filtering.

- Runs in Docker
- Available on LAN and Tailscale
- Admin interface uses ports 80/443

Useful check:

```bash
docker ps | grep pihole
```

## Immich

Self-hosted photo and video management.

Main containers:

```text
immich_server
immich_postgres
immich_redis
immich_machine_learning
```

Web interface:

```text
Port: 2283
```

Persistent data:

```text
/mnt/immichvault/immich/
```

Immich depends on the encrypted storage being mounted before startup.

## Vaultwarden

Self-hosted Bitwarden-compatible password manager.

Container access is restricted to localhost:

```text
127.0.0.1:8081
```

Persistent data:

```text
/mnt/immichvault/apps/vaultwarden
```

Remote access is provided through Tailscale Serve over HTTPS.

Public account registration is disabled:

```text
SIGNUPS_ALLOWED=false
```

## Paperless-ngx

Document management and OCR.

Web interface:

```text
Port: 8000
```

Persistent data:

```text
/mnt/immichvault/apps/paperless/
```

Main containers:

```text
paperless-web
paperless-broker
```

## Homepage

Central dashboard containing links to the main homelab services.

```text
Port: 3000
```

## Uptime Kuma

Monitors service availability.

```text
Port: 3001
```

Used to monitor services including Immich, Pi-hole, Homepage, Netdata and Paperless-ngx.

## Netdata

Host and container performance monitoring.

```text
Port: 19999
```

Used for CPU, RAM, disk, network and Docker monitoring.

## OctoPrint

Remote control and monitoring for an Ender 3 V3 SE.

```text
Port: 5000
USB device: /dev/ttyUSB0
```

The printer must be physically connected for the USB device to exist.

Useful check:

```bash
ls -l /dev/ttyUSB* /dev/ttyACM*
```

## Tailscale

Private mesh VPN used for remote access to the server and internal services.

Useful commands:

```bash
tailscale status
tailscale ip
tailscale serve status
```

## SSH

Primary method for command-line administration.

```bash
ssh <USER>@<SERVER_IP>
```
