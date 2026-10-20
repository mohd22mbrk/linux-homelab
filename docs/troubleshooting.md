# Troubleshooting

## Immich Started Before Encrypted Storage

### Symptom

After reboot, Immich appeared to be a fresh installation with no existing users or photos.

### Cause

Docker started the containers before the LUKS drive was unlocked.

The expected bind-mount paths existed, but the real encrypted data was not mounted.

### Fix

Stop Immich:

```bash
docker stop immich_server immich_postgres immich_redis immich_machine_learning
```

Unlock storage:

```bash
unlock-immich
```

Start Immich:

```bash
~/start-immich.sh
```

### Prevention

Storage-dependent containers were changed to:

```text
restart: "no"
```

---

## PostgreSQL Startup Race

### Symptom

`immich_server` exited during startup.

PostgreSQL reported:

```text
57P03 database system is starting up
```

### Cause

The Immich server started before PostgreSQL was ready to accept connections.

### Fix

`start-immich.sh` was changed to start the dependencies first and wait for PostgreSQL and Redis health checks before starting `immich_server`.

---

## Immich Exit Code 139

### Symptom

Immich v3.0.2 occasionally exited with:

```text
Exit code 139
```

### Investigation

The failure occurred during normal Immich processing while the host and other services remained available.

### Resolution

Immich was updated to v3.2.2.

The crash did not continue after the update.

---

## Backup Drive Not Mounted

### Symptom

A scheduled backup could not run because the encrypted backup drive was not mounted.

### Risk

Running rsync against an empty mount-point directory could write backup data to the wrong filesystem.

### Fix

Mount checks were added:

```bash
mountpoint -q /mnt/immichvault
mountpoint -q /mnt/backupvault
```

The backup exits if either check fails.

---

## DNS Resolution Failure

### Symptom

Commands such as:

```bash
sudo apt update
```

could not resolve repository hostnames.

### Investigation

The server DNS configuration was pointing to the Tailscale DNS resolver while name resolution was not working correctly.

Useful checks:

```bash
cat /etc/resolv.conf
resolvectl status
```

### Recovery

Temporary public DNS resolvers were used while the DNS configuration was corrected.

---

## LAN Connectivity Investigation

### Symptom

LAN clients temporarily could not ping or SSH to the server even though the server remained powered on.

### Findings

System logs showed that Ubuntu continued running scheduled jobs.

No clear NIC carrier loss or adapter reset was found.

An older previously stable kernel was used as an A/B test.

### Checks for Future Recurrence

Before rebooting the server:

```bash
ip addr
ip route
ip neigh
ping <GATEWAY_IP>
```

From the client:

```text
ping <SERVER_LAN_IP>
arp -a
```

This preserves more information about the network state before recovery actions are taken.

---

## OctoPrint / USB Device Missing

### Symptom

OctoPrint cannot communicate with the printer.

### Check

```bash
ls -l /dev/ttyUSB* /dev/ttyACM*
```

Expected device when connected:

```text
/dev/ttyUSB0
```

Start container:

```bash
docker start octoprint
```
