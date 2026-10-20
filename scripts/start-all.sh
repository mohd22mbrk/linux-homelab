#!/bin/bash
set -e

echo "Unlocking encrypted storage..."
unlock-immich

echo
echo "Starting Immich..."
~/start-immich.sh

echo
echo "Starting encrypted homelab services..."
cd /home/<USER>/homelab
docker compose up -d homepage uptime-kuma vaultwarden paperless-broker paperless-web

echo
echo "===== STATUS ====="
docker ps --format 'table {{.Names}}\t{{.Status}}'
