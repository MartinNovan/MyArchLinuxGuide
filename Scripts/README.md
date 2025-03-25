# Useful Scripts for Arch Linux

This folder contains various useful scripts for managing and maintaining an Arch Linux system.

## Contents

### Clean.sh
- **Description:** Script for system cleanup
- **Functions:**
  - Clean Pacman cache
  - Remove orphaned packages
  - Clean user cache
  - Calculate freed space
- **Usage:**
```bash
sh ./Clean.sh
```

### Update.sh
- **Description:** Script for system update
- **Functions:**
  - Update system packages
  - Update AUR packages
  - Check for updates
- **Usage:**
```bash
sh ./Update.sh
```

### Backup.sh
- **Description:** Script for backing up important files
- **Functions:**
  - Backup configuration files
  - Backup list of installed packages
  - Compress backup
- **Usage:**
```bash
sh ./Backup.sh
```

## Related Documents

- [UsefulCommands](../UsefulCommands/README.md) - List of useful commands for Pacman and Yay
- [PackageManagement.md](../PackageManagement.md) - Package management guide
- [SecurityHardening.md](../SecurityHardening.md) - System security recommendations

## Best Practices

1. **Regular Maintenance**
   - Run Clean.sh at least once a month
   - Regularly update the system using Update.sh

2. **Backups**
   - Perform backups before major changes
   - Store backups on external storage

3. **Security**
   - Check script contents before running
   - Use only trusted scripts

## References
- [Arch Wiki - Pacman](https://wiki.archlinux.org/title/Pacman)
- [Arch Wiki - Yay](https://wiki.archlinux.org/title/AUR_helpers)
- [Arch Wiki - System maintenance](https://wiki.archlinux.org/title/System_maintenance) 