# Networking

## LAN

The server uses wired Ethernet.

Private addresses are replaced with placeholders in public documentation.

```text
Server: <SERVER_LAN_IP>
Gateway: <GATEWAY_IP>
```

Useful commands:

```bash
ip addr
ip route
ip neigh
```

## SSH

Local administration:

```bash
ssh <USER>@<SERVER_LAN_IP>
```

Remote administration can also use the server's Tailscale address.

## Tailscale

Tailscale provides private remote access without exposing the server directly through router port forwarding.

Check status:

```bash
tailscale status
```

Check assigned addresses:

```bash
tailscale ip
```

## Tailscale Serve

Vaultwarden listens only on:

```text
127.0.0.1:8081
```

Tailscale Serve provides HTTPS access to it inside the tailnet.

Check configuration:

```bash
tailscale serve status
```

## Pi-hole DNS

Pi-hole provides DNS filtering for the local network.

Useful DNS checks:

```bash
resolvectl status
cat /etc/resolv.conf
```

## Listening Ports

Useful check:

```bash
ss -tulpn
```

Main application ports:

```text
2283   Immich
3000   Homepage
3001   Uptime Kuma
5000   OctoPrint
8000   Paperless-ngx
19999  Netdata
```

## Basic Troubleshooting

Server:

```bash
ip addr
ip route
ip neigh
ping <GATEWAY_IP>
ss -tulpn
```

Client:

```bash
ping <SERVER_LAN_IP>
arp -a
```
