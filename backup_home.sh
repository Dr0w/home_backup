#!/bin/bash
SOURCE="/home/$USER/"
DEST="/mnt/backup/ubuntu_home_backup/"
DATE=$(date +%Y-%m-%d)
PREV_BACKUP=$(ls -td ${DEST}* | head -1)
EXCLUDE_FILE="rsync-homedir-excludes.txt"

mkdir -p "${DEST}${DATE}"

# Check if a previous backup exists
if [ -d "${PREV_BACKUP}" ]; then
    rsync -aP --delete --no-group --no-times --no-perms --no-specials --copy-links \
          --exclude-from="${EXCLUDE_FILE}" --link-dest="${PREV_BACKUP}" "$SOURCE" "${DEST}${DATE}/"
else
    rsync -aP --delete --no-group --no-times --no-perms --no-specials --copy-links \
          --exclude-from="${EXCLUDE_FILE}" "$SOURCE" "${DEST}${DATE}/"
fi

# Remove old backups if needed (optional). mtime sets max days for backups to store
find "${DEST}" -mindepth 1 -maxdepth 1 -type d -mtime +7 -exec rm -rf {} \;
