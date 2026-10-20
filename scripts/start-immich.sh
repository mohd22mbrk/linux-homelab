#!/bin/bash
set -e

if ! mountpoint -q /mnt/immichvault; then
    echo "ERROR: Immich encrypted storage is not mounted."
    exit 1
fi

echo "Starting Immich dependencies..."

docker start immich_postgres immich_redis immich_machine_learning >/dev/null 2>&1 || true

echo "Waiting for PostgreSQL and Redis..."

for i in $(seq 1 60); do

    PG=$(docker inspect -f '{{if .State.Health}}{{.State.Health.Status}}{{else}}{{.State.Status}}{{end}}' immich_postgres 2>/dev/null || echo down)

    REDIS=$(docker inspect -f '{{if .State.Health}}{{.State.Health.Status}}{{else}}{{.State.Status}}{{end}}' immich_redis 2>/dev/null || echo down)

    if [ "$PG" = "healthy" ] && [ "$REDIS" = "healthy" ]; then
        echo "Database and Redis are healthy."
        break
    fi

    sleep 2
done

if [ "$PG" != "healthy" ] || [ "$REDIS" != "healthy" ]; then
    echo "ERROR: Immich dependencies did not become healthy."
    exit 1
fi

docker start immich_server >/dev/null

echo "Immich started."
