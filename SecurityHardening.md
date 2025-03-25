# Arch Linux System Security

## Introduction
System security is a complex process that involves multiple layers of protection. This document describes basic and advanced methods for securing Arch Linux.

## Basic Security

### Password Management
#### Strong Passwords
```bash
# Generate strong password
openssl rand -base64 32

# Change password
passwd

# Set password policy in /etc/security/pwquality.conf
minlen = 12
minclass = 4
maxrepeat = 3
```

#### PAM Configuration
```bash
# /etc/pam.d/system-auth
auth required pam_faillock.so preauth silent deny=3 unlock_time=600
auth required pam_unix.so try_first_pass nullok
auth [default=die] pam_faillock.so authfail
auth optional pam_permit.so
auth required pam_env.so
```

### Firewall
#### UFW (Uncomplicated Firewall)
```bash
# Basic setup
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable

# Advanced rules
ufw limit ssh
ufw allow from 192.168.1.0/24 to any port 80
```

#### iptables
```bash
# Basic rules
iptables -F
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
```

## System Security

### Kernel Hardening
#### Sysctl Settings
```bash
# /etc/sysctl.d/99-security.conf
kernel.kptr_restrict=2
kernel.dmesg_restrict=1
kernel.unprivileged_bpf_disabled=1
net.core.bpf_jit_harden=2
kernel.yama.ptrace_scope=2
```

#### Disable Modules
```bash
# /etc/modprobe.d/blacklist.conf
blacklist cramfs
blacklist freevxfs
blacklist jffs2
blacklist hfs
blacklist hfsplus
blacklist udf
```

### Filesystem Security
```bash
# /etc/fstab
/dev/sda1 /boot          ext4    defaults,nodev,nosuid,noexec 0 2
/dev/sda2 /              ext4    defaults,nodev 0 1
/dev/sda3 /home          ext4    defaults,nodev,nosuid 0 2
tmpfs     /tmp           tmpfs   defaults,nodev,nosuid,noexec 0 0
```

## Application Security

### SELinux/AppArmor
```bash
# Install AppArmor
pacman -S apparmor

# Enable in bootloader
GRUB_CMDLINE_LINUX="apparmor=1 security=apparmor"

# Basic profiles
aa-enforce /etc/apparmor.d/*
```

### ASLR and Other Protections
```bash
# /etc/sysctl.d/99-sysctl.conf
kernel.randomize_va_space=2
fs.protected_hardlinks=1
fs.protected_symlinks=1
```

## Monitoring and Auditing

### Auditd
```bash
# Installation
pacman -S audit

# Basic rules in /etc/audit/rules.d/audit.rules
-w /etc/passwd -p wa -k identity
-w /etc/group -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/sudoers -p wa -k sudo_changes
```

### Logging
```bash
# Rsyslog configuration
*.* action(type="omfwd" target="logserver" port="514" protocol="tcp")

# Journald settings
Storage=persistent
Compress=yes
SystemMaxUse=2G
```

## Network Security

### SSH Hardening
```bash
# /etc/ssh/sshd_config
PermitRootLogin no
PasswordAuthentication no
MaxAuthTries 3
AllowUsers user1 user2
Protocol 2
```

### Fail2ban
```bash
# /etc/fail2ban/jail.local
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 3

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
```

## Advanced Security

### LUKS Encryption
```bash
# Create encrypted partition
cryptsetup luksFormat /dev/sda2

# Open partition
cryptsetup open /dev/sda2 cryptroot

# /etc/crypttab
cryptroot UUID=xxx none luks
```

### Secure Boot
```bash
# Generate keys
openssl req -new -x509 -newkey rsa:2048 -keyout MOK.key -out MOK.crt
sbsign --key MOK.key --cert MOK.crt --output /boot/vmlinuz-linux /boot/vmlinuz-linux
```

## Intrusion Detection

### AIDE (Advanced Intrusion Detection Environment)
```bash
# Installation
pacman -S aide

# Initialize database
aide --init
mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# System check
aide --check
```

### Rootkit Detection
```bash
# Install rkhunter
pacman -S rkhunter

# Update database
rkhunter --update
rkhunter --propupd

# System check
rkhunter --check
```

## Automation and Maintenance

### Automatic Updates
```bash
# /etc/systemd/system/security-updates.service
[Unit]
Description=Daily security updates

[Service]
Type=oneshot
ExecStart=/usr/bin/pacman -Syu --noconfirm

[Install]
WantedBy=multi-user.target
```

### Regular Checks
```bash
# Security check script
#!/bin/bash
aide --check
rkhunter --check
fail2ban-client status
aureport --summary
```

## Best Practices

### Basic Principles
1. **Principle of Least Privilege**
   - Use sudo instead of root
   - Restrict file access
   - Use SELinux/AppArmor

2. **Regular Maintenance**
   - System updates
   - Log checks
   - Configuration backups

3. **Monitoring**
   - Monitor unusual activity
   - Regular security audits
   - Security testing

### Checklist
- [ ] Strong passwords for all accounts
- [ ] Active firewall
- [ ] Updated system
- [ ] Secured SSH
- [ ] Active monitoring
- [ ] Encrypted disks
- [ ] Regular backups
- [ ] Documented changes

## References
- [Arch Wiki - Security](https://wiki.archlinux.org/title/Security)
- [Arch Wiki - AppArmor](https://wiki.archlinux.org/title/AppArmor)
- [Arch Wiki - SELinux](https://wiki.archlinux.org/title/SELinux) 