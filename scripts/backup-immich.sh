#!/bin/bash

SOURCE="/mnt/immichvault/"
DEST="/mnt/backupvault/immich-backup/"
LOG="/home/<USER>/backup.log"

echo "===== $(date) =====" >> "$LOG"

if ! mountpoint -q /mnt/immichvault; then
    echo "ERROR: Immich vault is not mounted. Backup cancelled." >> "$LOG"
    exit 1
fi

if ! mountpoint -q /mnt/backupvault; then
    echo "ERROR: Backup vault is not mounted. Backup cancelled." >> "$LOG"
    exit 1
fi

rsync -aHAX --delete --info=progress2 \
--exclude='immich/postgres/' \
--exclude='lost+found/' \
"$SOURCE" \
"$DEST" >> "$LOG" 2>&1

RESULT=$?

if [ $RESULT -eq 0 ]; then
    echo "Backup completed successfully." >> "$LOG"
else
    echo "ERROR: Backup failed. rsync exit code: $RESULT" >> "$LOG"
fi

echo "" >> "$LOG"
exit $RESULT
