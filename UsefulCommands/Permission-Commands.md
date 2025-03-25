# Permission Management - Useful Commands

## Basic Permissions
### Changing Permissions (chmod)
```bash
# Basic syntax
chmod [options] mode file

# Numeric notation
chmod 755 file  # rwxr-xr-x
chmod 644 file  # rw-r--r--
chmod 700 file  # rwx------

# Symbolic notation
chmod u+x file  # Add execute permission for owner
chmod g+w file  # Add write permission for group
chmod o-r file  # Remove read permission for others
```

### Changing Ownership (chown)
```bash
# Change owner
chown user file

# Change owner and group
chown user:group file

# Recursive change
chown -R user:group directory/

# Change group only (chgrp)
chgrp group file
```

## Special Permissions
### SUID, SGID and Sticky bit
```bash
# Set SUID (4000)
chmod u+s file
chmod 4755 file

# Set SGID (2000)
chmod g+s directory
chmod 2755 directory

# Set Sticky bit (1000)
chmod +t directory
chmod 1777 directory
```

### ACL (Access Control Lists)
```bash
# View ACL
getfacl file

# Set ACL for user
setfacl -m u:user:rwx file

# Set ACL for group
setfacl -m g:group:rx file

# Remove all ACL
setfacl -b file
```

## Default Permissions
### Umask
```bash
# Show current mask
umask

# Set umask
umask 022  # For files: 644, For directories: 755
umask 077  # For files: 600, For directories: 700

# Temporary change
umask -S u=rwx,g=rx,o=rx
```

### Default ACL
```bash
# Set default ACL for directory
setfacl -d -m u:user:rwx directory

# Copy ACL
getfacl source | setfacl --set-file=- target
```

## Bulk Changes
### Recursive Operations
```bash
# Recursive chmod
chmod -R 755 directory/

# Only files
find directory -type f -exec chmod 644 {} \;

# Only directories
find directory -type d -exec chmod 755 {} \;

# Combined commands
find directory -type f -exec chmod 644 {} \; -o -type d -exec chmod 755 {} \;
```

## Checking and Auditing
### Viewing Permissions
```bash
# Detailed listing
ls -l file

# Listing including ACL
ls -l+ file

# Numeric listing
stat -c "%a %n" file

# Complete information
stat file
```

### Searching by Permissions
```bash
# Find SUID files
find / -perm -4000

# Find SGID files
find / -perm -2000

# Find world-writable files
find / -perm -2 -type f -print

# Find files without owner
find / -nouser -o -nogroup
```

## Security Measures
### Fixing Permissions
```bash
# Fix home directory
chmod 700 /home/user
chmod 755 /home

# Fix system files
chmod 644 /etc/passwd
chmod 600 /etc/shadow

# Fix executable files
chmod 755 /usr/local/bin/*
```

### Security Checks
```bash
# Check important files
ls -l /etc/passwd /etc/shadow /etc/group
ls -l /etc/sudoers
ls -l /etc/ssh/sshd_config

# Check dangerous permissions
find / -type f -perm -0777 -print
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias ll='ls -la'
alias lh='ls -lah'
alias perms='stat -c "%a %n"'
alias suid='find / -perm -4000 2>/dev/null'
```

## Troubleshooting
```bash
# Reset permissions to default
find /home/user -type f -exec chmod 644 {} \;
find /home/user -type d -exec chmod 755 {} \;

# Remove extended permissions
chmod --reference=/etc/passwd file

# System integrity check
rpm -Va  # For RPM-based systems
dpkg -V  # For Debian-based systems
```