# Data Synchronization - Useful Commands

## Rsync
### Basic Synchronization
```bash
# Basic synchronization
rsync -av source/ target/

# Synchronization with deletion
rsync -av --delete source/ target/

# Synchronization over SSH
rsync -avz -e ssh source/ user@server:target/

# Dry run (test)
rsync -av --dry-run source/ target/
```

### Advanced Options
```bash
# Exclude files
rsync -av --exclude='*.tmp' source/ target/

# Preserve permissions
rsync -avp source/ target/

# Limit bandwidth
rsync -av --bwlimit=1000 source/ target/

# Incremental backups
rsync -av --link-dest=../backup.1 source/ backup.0/
```

## Unison
### Basic Usage
```bash
# Synchronize two directories
unison dir1 dir2

# Synchronize with profile
unison profile

# Automatic synchronization
unison -batch profile

# Synchronization over SSH
unison local ssh://user@host//path
```

### Configuration
```bash
# Create profile
# ~/.unison/profile.prf
root = /path/to/dir1
root = ssh://user@host//path/to/dir2
ignore = Name *.tmp
```

## Syncthing
### Service Management
```bash
# Start service
systemctl start syncthing@user

# Enable on startup
systemctl enable syncthing@user

# Check status
systemctl status syncthing@user
```

### Configuration
```bash
# Web interface
http://localhost:8384

# Configuration via CLI
syncthing cli
```

## Git
### Basic Synchronization
```bash
# Clone repository
git clone url

# Pull changes
git pull

# Push changes
git push

# Synchronize all branches
git fetch --all
```

### Advanced Operations
```bash
# Synchronize specific branch
git pull origin branch

# Synchronize with rebase
git pull --rebase

# Synchronize submodules
git submodule update --init --recursive
```

## Rclone
### Basic Operations
```bash
# Synchronize to cloud
rclone sync source remote:target

# Copy files
rclone copy source remote:target

# List contents
rclone ls remote:path

# Test configuration
rclone check source remote:target
```

### Cloud Services
```bash
# Google Drive
rclone sync /local/path gdrive:backup

# Dropbox
rclone sync /local/path dropbox:backup

# OneDrive
rclone sync /local/path onedrive:backup
```

## Automatic Synchronization
### Inotify
```bash
# Monitor changes
inotifywait -m -r -e modify,create,delete /path

# Automatic synchronization
while inotifywait -r -e modify,create,delete /source; do
    rsync -av /source/ /target/
done
```

### Cron Jobs
```bash
# Regular synchronization
*/15 * * * * rsync -av /source/ /target/

# Daily synchronization
0 2 * * * unison -batch profile

# Weekly full synchronization
0 3 * * 0 rsync -av --delete /source/ /target/
```

## Network Synchronization
### NFS
```bash
# Mount NFS
mount -t nfs server:/share /mnt/point

# Automatic mount (fstab)
server:/share /mnt/point nfs defaults 0 0

# Synchronization with NFS
rsync -av /data/ /mnt/point/
```

### Samba
```bash
# Mount Samba share
mount -t cifs //server/share /mnt/point -o user=user

# Synchronization with Samba
rsync -av /data/ /mnt/point/

# Automatic mount
//server/share /mnt/point cifs credentials=/etc/samba/credentials 0 0
```

## Synchronization Monitoring
### Logs and Notifications
```bash
# Log rsync
rsync -av --log-file=sync.log source/ target/

# Email notification
rsync -av source/ target/ && mail -s "Sync complete" admin@example.com

# Error monitoring
tail -f sync.log | grep "error"
```

### Statistics
```bash
# Transfer statistics
rsync -av --stats source/ target/

# Progress of synchronization
rsync -av --progress source/ target/

# Detailed statistics
rsync -av --info=progress2 source/ target/
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias rsync-safe='rsync -av --dry-run'
alias rsync-sync='rsync -av --delete'
alias rsync-backup='rsync -av --backup --backup-dir'
alias unison-auto='unison -batch'
```

## Troubleshooting
```bash
# Debug mode
rsync -avv --progress source/ target/

# Check connection
ping server
nc -zv server 22

# Check permissions
ls -la /source/
ls -la /target/
```

## Security
```bash
# SSH keys for automatic synchronization
ssh-keygen -t ed25519
ssh-copy-id user@server

# Restrict access
chmod 600 ~/.ssh/config
chmod 700 ~/.ssh

# Encrypted transfer
rsync -av -e "ssh -c aes256-gcm@openssh.com" source/ target/
```