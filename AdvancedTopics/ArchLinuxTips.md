# Useful Tips and Tricks for Arch Linux

## Package Management

### Quick Package Search
```bash
pacman -Ss search_term
```

### Display Package Information
```bash
pacman -Si package
```

### List Installed Packages
```bash
pacman -Qe
```

### Clean Cache
```bash
sudo pacman -Scc
```

## System Management

### Display Free Space
```bash
df -h
```

### Find Large Files
```bash
find / -size +100M
```

### Process Monitoring
```bash
htop
```

## Useful Aliases

### Add to .bashrc or .zshrc
```bash
alias update='sudo pacman -Syu'
alias clean='sudo pacman -Rns $(pacman -Qtdq)'
alias ll='ls -la'
alias grep='grep --color=auto'
```

## Quick Commands

### Display System Information
```bash
neofetch
```

### Disk Speed Test
```bash
sudo hdparm -Tt /dev/sda
```

### Temperature Monitoring
```bash
sensors
```

## Useful Scripts

### Backup Package List
```bash
pacman -Qqe > pkglist.txt
```

### Restore Packages from List
```bash
pacman -S - < pkglist.txt
```

## Best Practices

1. **Regular Updates**
   - Update the system at least once a week
   - Check Arch Linux news before updating

2. **Backups**
   - Regularly backup important files
   - Maintain a list of installed packages

3. **Documentation**
   - Record changes made
   - Keep important commands

## References
- [Arch Wiki - Tips and tricks](https://wiki.archlinux.org/title/General_recommendations)
- [Arch Wiki - Pacman tips](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks)
- [Arch Wiki - System maintenance](https://wiki.archlinux.org/title/System_maintenance)