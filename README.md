# Home folder Backup Script

This project provides a script to back up your home directory to a network-mounted filesystem using `rsync`. The script supports incremental backups and logs the backup process.

## Prerequisites

**Network-Mounted Filesystem**

   Ensure your backup directory is mounted. Add the following line to your `/etc/fstab`:

   ```//10.0.0.196/Backups /mnt/backup cifs credentials=/etc/samba/credentials,iocharset=utf8,file_mode=0777,dir_mode=0777,vers=3.0 0 0```

Mount the directory:

``` sudo mount -a```

**Exclusion List**

This project uses the rsync-homedir-excludes list to exclude unnecessary files and directories from the backup.

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

## Backup Script

The backup_home.sh script performs the backup. Here is how to use it:

### Running the Script

Make the script executable:

```chmod +x backup_home.sh```

Run the script:

```./backup_home.sh```

### Logging

The script logs the backup process to home_backup.log. You can view the log file to check the status of your backups.

### Maintenance

**Adjust Backup Retention:** Modify the ```-mtime +7``` parameter in the find command to change how long backups are retained.

**Update Exclusions:** Edit rsync-homedir-local.txt to add or remove paths from the backup.


## Troubleshooting

**Mount Issues:** Ensure the backup directory is properly mounted by checking /etc/fstab and running ```sudo mount -a```.

**Permissions:** Ensure you have the necessary permissions to read from the source and write to the destination directories.

**Network Stability:** Verify the network connection to the backup server is stable.

*** Feel free to reach out if you encounter any issues or have questions about the script! ***
