# Home Backup Script

This project provides a script to back up your home directory to a network-mounted filesystem using rsync. The script supports incremental backups and logs the backup process.

## Prerequisites

**Network-Mounted Filesystem**

Ensure your backup directory is mounted. Add the following line to your /etc/fstab:

```//10.0.0.196/Backups /mnt/backup cifs credentials=/etc/samba/credentials,iocharset=utf8,file_mode=0777,dir_mode=0777,vers=3.0 0 0```

Mount the directory:

```sudo mount -a```

**Exclusion List**

This project uses the rsync-homedir-excludes list to exclude unnecessary files and directories from the backup.

Cheers to **rubo77** (https://github.com/rubo77/rsync-homedir-excludes.git)

Download the exclusion list:

```wget https://raw.githubusercontent.com/rubo77/rsync-homedir-excludes/master/rsync-homedir-excludes.txt -O rsync-homedir-local.txt```

Or clone the repository and copy the exclusion list:

```
git clone https://github.com/rubo77/rsync-homedir-excludes
cd rsync-homedir-excludes
cp rsync-homedir-excludes.txt ../rsync-homedir-local.txt
```

Edit the exclusion list to your needs:

```nano rsync-homedir-local.txt```

Usage

### Backup Script Overview

The backup_home.sh script performs the backup with key functionalities including:

**Source Directory:** Your home directory (/home/$USER/)
**Destination Directory:** The mounted backup location (/mnt/backup/ubuntu_home_backup/)
**Incremental Backups:** Uses rsync with hard links to optimize storage.
**Logging:** Logs backup operations to home_backup.log.
**Retention Policy:** Keeps backups for a configurable number of days (default: 7).

**Running the Script**

Make the script executable:

```chmod +x backup_home.sh```

Run the script:

```./backup_home.sh```

**Logging**

The script logs the backup process to home_backup.log. You can check this log for detailed information on each backup operation:

```cat home_backup.log```

**Maintenance**

Adjust Backup Retention
To modify how long backups are retained, update the -mtime +7 parameter in the script:

Retain for 30 days:
```-mtime +30```
Retain for 14 days:
```-mtime +14```

Update Exclusions
Edit rsync-homedir-local.txt to customize the files and directories excluded from the backup:

```nano rsync-homedir-local.txt```

## Troubleshooting

Common Issues:
**Mount Issues:** Ensure the backup directory is correctly mounted by verifying /etc/fstab and running:

```sudo mount -a```

Permissions: Verify you have the necessary permissions to read from the source and write to the destination directories.

Network Stability: Ensure the network connection to the backup server is stable. Test with:

```ping 10.0.0.196```

***Feel free to reach out if you encounter any issues or have questions about the script!***
