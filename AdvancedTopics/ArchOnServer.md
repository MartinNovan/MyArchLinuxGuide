# Arch Linux on Server

## Introduction
This document describes specific aspects of using Arch Linux as a server operating system, including performance optimization, security, and service management.

## Basic Setup

### Minimal Installation
```bash
pacstrap /mnt base linux linux-firmware
```

### Network Configuration
```bash
sudo pacman -S networkmanager
sudo systemctl enable NetworkManager
```

### Timezone Setup
```bash
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc
```

## Performance Optimization

### I/O Scheduler
```bash
echo deadline | sudo tee /sys/block/sda/queue/scheduler
```

### TCP Tuning
```bash
echo 'net.core.rmem_max=16777216' | sudo tee -a /etc/sysctl.conf
echo 'net.core.wmem_max=16777216' | sudo tee -a /etc/sysctl.conf
```

### Increase File Limits
```bash
echo '* soft nofile 65536' | sudo tee -a /etc/security/limits.conf
echo '* hard nofile 65536' | sudo tee -a /etc/security/limits.conf
```

## Security

### Firewall
```bash
sudo pacman -S ufw
sudo ufw allow ssh
sudo ufw enable
```

### SELinux
```bash
sudo pacman -S selinux
sudo nano /etc/selinux/config
```

### Automatic Updates
```bash
sudo pacman -S unattended-upgrades
sudo systemctl enable unattended-upgrades
```

## Service Management

### Web Server
```bash
sudo pacman -S nginx
sudo systemctl enable nginx
```

### Database
```bash
sudo pacman -S mariadb
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable mariadb
```

### Email Server
```bash
sudo pacman -S postfix
sudo systemctl enable postfix
```

## Monitoring

### Basic Tools
```bash
sudo pacman -S htop iotop iftop
```

### Logging
```bash
sudo pacman -S rsyslog
sudo systemctl enable rsyslog
```

### Alerts
```bash
sudo pacman -S monit
sudo systemctl enable monit
```

## Backup

### Rsync
```bash
sudo pacman -S rsync
```

### Cron Jobs
```bash
0 3 * * * rsync -avz /important/data backup@server:/backup
```

### Automatic Backup
```bash
sudo pacman -S bacula
sudo systemctl enable bacula
```

## Best Practices

1. **Security**
   - Regularly update the system
   - Use strong passwords
   - Restrict access to services

2. **Monitoring**
   - Monitor resource usage
   - Set alerts for critical values
   - Analyze logs

3. **Backup**
   - Regularly backup data
   - Test backup restoration
   - Maintain backups on external storage

## Useful References
- [Arch Wiki - Server](https://wiki.archlinux.org/title/Server)
- [Arch Wiki - Security](https://wiki.archlinux.org/title/Security)
- [Arch Wiki - Network configuration](https://wiki.archlinux.org/title/Network_configuration)