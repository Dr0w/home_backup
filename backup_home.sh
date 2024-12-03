#!/bin/bash
SOURCE="/home/$USER/"
DEST="/mnt/backup/ubuntu_home_backup/"
DATE=$(date +%Y-%m-%d)
PREV_BACKUP=$(find "${DEST}" -mindepth 1 -maxdepth 1 -type d | sort -r | head -1)
EXCLUDE_FILE="rsync-homedir-excludes.txt"
LOG_FILE="home_backup.log"

mkdir -p "${DEST}${DATE}"

# Check if a previous backup exists
if [ -d "${PREV_BACKUP}" ]; then
    rsync -aP --delete --no-group --no-times --no-perms --no-specials --copy-links \
          --exclude-from="${EXCLUDE_FILE}" --link-dest="${PREV_BACKUP}" \
          "$SOURCE" "${DEST}${DATE}/" 2>&1 | tee -a "${LOG_FILE}"
else
    rsync -aP --delete --no-group --no-times --no-perms --no-specials --copy-links \
          --exclude-from="${EXCLUDE_FILE}" "$SOURCE" "${DEST}${DATE}/" 2>&1 | tee -a "${LOG_FILE}"
fi

# Remove old backups if needed (optional) Sets number of days to hold the backup
find "${DEST}" -mindepth 1 -maxdepth 1 -type d -mtime +7 -exec rm -rf {} \;