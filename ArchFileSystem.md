# Arch Linux File System

## Introduction
Arch Linux uses a standard hierarchical file system structure according to FHS (Filesystem Hierarchy Standard). This document describes the main directories and their purposes.

## Basic Structure
### / (Root)
The root directory, contains all other directories. It's the starting point of the entire file system.

### /boot
- Contains files needed for system boot
- Bootloader (GRUB/systemd-boot)
- Linux kernel (usually named vmlinuz-linux)
- initramfs images (initial RAM disk)
- Bootloader configuration files

### /etc
- System configuration
- Service configuration files
- Network configuration (/etc/network)
- Security settings
- Important files like:
  - /etc/fstab (file system mount configuration)
  - /etc/passwd (user database)
  - /etc/hosts (IP address to hostname mapping)

### /home
- User home directories
- Personal data and configurations
- Dotfiles (.bashrc, .config, etc.)
- Each user has their own /home/user directory

### /usr
- Programs and applications
- Shared libraries
- Documentation
- Source codes
- Largest directory in the system
- Contains most installed software

### /var
- Variable data
- System logs (/var/log)
- Cache (/var/cache)
- Spool files
- Databases
- Size changes during system operation

### /tmp
- Temporary files
- Automatically cleared on reboot
- Accessible to all users
- Often located in RAM for faster access

### /opt
- Optional packages
- Third-party software
- Standalone applications (e.g., Google Chrome, Discord)
- Each application has its own directory

### /srv
- Data for services provided by the system
- Web servers (e.g., /srv/http)
- FTP servers
- Other network services

### /dev
- Contains device files
- Represents hardware devices in the system
- Managed by udev system
- Contains for example:
  - /dev/sda (first disk)
  - /dev/tty (terminals)
  - /dev/null (empty device)

### /lost+found
- Used for recovering damaged files
- Should be empty in normal state
- Each ext file system has its own /lost+found
- Created automatically during formatting
- Used by fsck during system repair

### /mnt
- Mount point for temporary file systems
- Used for manual disk mounting
- Suitable for external devices
- Commonly used by system administrators

### /proc
- Virtual file system
- Provides information about running processes
- Contains system information
- Important files:
  - /proc/cpuinfo (CPU information)
  - /proc/meminfo (memory information)
  - /proc/version (kernel version)

### /root
- Home directory for root user
- Separated from /home for security reasons
- Contains superuser configuration files
- Accessible only to root

### /run
- Runtime variable data
- Contains information since system boot
- Cleared on system start
- Used for PID files and socket files

## Important Subdirectories
### /usr/bin
- Executable programs
- Commands for all users
- In modern systems, this directory is a symbolic link to /bin

### /usr/lib
- System libraries
- Kernel modules
- Symbolic link to /lib
- Contains shared libraries needed for programs in /usr/bin

### /usr/share
- Architecture-independent data
- Documentation
- Localization files
- Icons, themes and other shared resources

### Symbolic Links in the System
In modern Arch Linux, some traditional directories are actually symbolic links (symlinks) to other locations. This is part of the "usr merge" concept where some root directory contents were moved to /usr:

- /bin → /usr/bin
- /lib → /usr/lib
- /lib64 → /usr/lib
- /sbin → /usr/bin

#### What is a Symbolic Link?
A symbolic link (or symlink) is a special type of file that serves as a reference or pointer to another file or directory. It's similar to a shortcut in Windows.

Examples of working with symbolic links:

Advantages of symbolic links:
- Can reference files across different file systems
- When the symlink is deleted, the original file remains intact
- Easy to identify (using ls -l)
- Can reference directories

## File System Management
### Permissions
Basic Linux permissions:
- r (read) - read
- w (write) - write
- x (execute) - execute

Examples of chmod usage:

```bash
# Add execute permission
chmod +x file

# Set permissions using numbers
chmod 755 file  # rwxr-xr-x
chmod 644 file  # rw-r--r--
```

Change owner using chown:
```bash
# Change owner
chown user:group file
```

### Links
#### Symbolic Links
- Can point anywhere in the system
- Stop working when the target is deleted
- Take up minimal space

#### Hard Links
- Must be on the same file system
- Work even after deleting the original file
- Share the same data as the original file

## Tips and Tricks
### Efficient /home Organization
- Use standard directories (Documents, Downloads, etc.)
- Store configuration files in ~/.config
- Use ~/.local for user programs

### Backing Up Important Directories
```bash
# Backup using rsync
rsync -av --delete /home/user /backup/

# Backup using tar
tar -czf backup.tar.gz /home/user
```

### System Cleaning
 - more in [UsefulCommands](UsefulCommands)
```bash
# Clean pacman cache
sudo paccache -r

# Remove unnecessary dependencies
sudo pacman -Rns $(pacman -Qtdq)

# Clean /tmp
sudo rm -rf /tmp/*
```

## Common Problems
### Solving Permission Issues
- Check owner and group
- Verify parent directory permissions
- Use `ls -la` to show all permissions

### Disk Space Management
```bash
# Show disk usage
df -h

# Find large files
du -sh /* | sort -h

# Analyze directory usage
ncdu /
```

### Recovering Deleted Files
- Use tools like testdisk or photorec
- Regularly back up important data
- Consider using file system snapshots

## Conclusion
Understanding the file system structure is crucial for effective Arch Linux management. Following standard conventions and regular maintenance will help keep the system clean and functional.
