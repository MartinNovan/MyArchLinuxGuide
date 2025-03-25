# Backup - Useful Commands

## Basic Backup
### Rsync
```bash
# Basic backup
rsync -av source/ target/

# Backup with exclusions
rsync -av --exclude='*.tmp' source/ target/

# Incremental backup
rsync -av --link-dest=../backup.1 source/ backup.0/

# Backup over SSH
rsync -avz -e ssh source/ user@server:target/
```

### Tar
```bash
# Create archive
tar -czf backup.tar.gz /path/to/data

# Extract archive
tar -xzf backup.tar.gz

# Incremental backup
tar --create --listed-incremental=snapshot.file \
    --file=backup.1.tar /path/to/data
```

## System Backups
### DD
```bash
# Full disk backup
dd if=/dev/sda of=/path/to/disk.img bs=4M status=progress

# Compressed backup
dd if=/dev/sda | gzip > disk.img.gz

# Restore from backup
dd if=disk.img of=/dev/sda bs=4M status=progress
```

### Clonezilla
```bash
# Partition backup
clonezilla

# Disk cloning
clonezilla-live

# System restore
clonezilla-restore
```

## Database Backups
### MySQL/MariaDB
```bash
# Database backup
mysqldump -u user -p database > backup.sql

# Backup all databases
mysqldump -u root -p --all-databases > all_db.sql

# Restore database
mysql -u user -p database < backup.sql
```

### PostgreSQL
```bash
# Database backup
pg_dump database > backup.sql

# Backup all databases
pg_dumpall > all_db.sql

# Restore database
psql database < backup.sql
```

## Backup Automation
### Cron Jobs
```bash
# Daily backup
0 2 * * * rsync -av /data/ /backup/

# Weekly backup
0 2 * * 0 tar -czf /backup/weekly.tar.gz /data/

# Monthly backup
0 2 1 * * mysqldump -u root -p"password" --all-databases > /backup/monthly_db.sql
```

### Scripts
```bash
#!/bin/bash
# Backup rotation
mv backup.2 backup.3
mv backup.1 backup.2
mv backup.0 backup.1
rsync -av --link-dest=../backup.1 /data/ backup.0/
```

## Network Backups
### Remote Backups
```bash
# Backup to NFS
mount -t nfs server:/backup /mnt/backup
rsync -av /data/ /mnt/backup/

# Backup over SSH
scp -r /data/ user@server:/backup/

# Backup using rclone
rclone sync /data/ remote:backup/
```

### Cloud Backups
```bash
# AWS S3
aws s3 sync /data/ s3://bucket/backup/

# Google Cloud Storage
gsutil -m rsync -r /data/ gs://bucket/backup/

# Rclone with cloud services
rclone sync /data/ gdrive:backup/
```

## Encrypted Backups
### GPG
```bash
# Encrypted backup
tar -czf - /data/ | gpg -c > backup.tar.gz.gpg

# Decrypt backup
gpg -d backup.tar.gz.gpg | tar -xzf -

# Encrypted network backup
tar -czf - /data/ | gpg -e -r "user" | ssh user@server "cat > backup.gpg"
```

## Backup Monitoring
### Verification
```bash
# Verify tar archive
tar -tvf backup.tar.gz

# Check rsync log
grep -i "error" /var/log/rsync.log

# Check free space
df -h /backup
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias backup='rsync -av --progress'
alias backup-db='mysqldump -u root -p'
alias check-backup='tar -tvf'
```

## Data Recovery
```bash
# Test recovery
tar -tzvf backup.tar.gz

# Selective recovery
tar -xzf backup.tar.gz path/to/file

# Restore with overwrite
rsync -av --delete backup/ /data/
```