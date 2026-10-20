# Security

## Encrypted Storage

Sensitive application data is stored on LUKS-encrypted drives.

The primary drive is manually unlocked after reboot rather than using an automatic unlock key stored on the server.

## Remote Access

Tailscale is used for remote administration and access to internal services.

This avoids directly exposing SSH and most web services to the public internet.

## Vaultwarden

Vaultwarden is bound only to localhost:

```text
127.0.0.1:8081
```

Remote access is provided through Tailscale Serve over HTTPS.

Public signups are disabled:

```text
SIGNUPS_ALLOWED=false
```

Vaultwarden data is stored on the encrypted drive.

## Controlled Startup

Services that depend on encrypted storage use:

```text
restart: "no"
```

This prevents them from automatically starting before the encrypted filesystem is mounted.

This is used for services including:

```text
Immich
Vaultwarden
Paperless-ngx
```

## Repository Secrets

The public Git repository excludes sensitive data including:

```text
.env files
passwords
LUKS passphrases
private SSH keys
API keys
Tailscale authentication keys
Vaultwarden exports
private local configuration
```

Public documentation uses placeholders where needed.

## Firewall

UFW is currently not enabled.

Docker, Pi-hole, SSH and Tailscale all interact with host networking, so firewall rules will be added only after testing the required traffic and Docker behaviour.
