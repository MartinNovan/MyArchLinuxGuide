# Security Commands - Useful Commands

## Basic Security
### System Check
```bash
# Check running services
systemctl list-units --type=service

# Check open ports
netstat -tulpn
ss -tuln

# Check active connections
lsof -i

# Check processes
ps aux
```

### User Management
```bash
# Check logged in users
who
w

# Login history
last
lastb

# Check sudo permissions
sudo -l
```

## Firewall
### UFW
```bash
# Firewall status
ufw status verbose

# Allow/deny ports
ufw allow 22
ufw deny 23

# Logging
ufw logging on
tail -f /var/log/ufw.log
```

### iptables
```bash
# Show rules
iptables -L -v

# Basic security rules
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -P INPUT DROP
```

## System Audit
### File Check
```bash
# Check SUID/SGID
find / -type f -perm /6000 -ls

# Check permissions
find / -nouser -o -nogroup

# Check integrity
aide --check
```

### Logging
```bash
# Check system logs
journalctl -p err..emerg

# System audit
auditctl -w /etc/passwd -p wa
ausearch -f /etc/passwd

# Check auth logs
tail -f /var/log/auth.log
```

## Encryption
### GPG
```bash
# Generate keys
gpg --full-generate-key

# Encrypt file
gpg -e -r "recipient" file

# Decrypt
gpg -d file.gpg
```

### Disk encryption
```bash
# Create encrypted partition
cryptsetup luksFormat /dev/sdX

# Open encrypted partition
cryptsetup open /dev/sdX name

# Close
cryptsetup close name
```

## Network Security
### SSH
```bash
# Secure SSH configuration
# /etc/ssh/sshd_config
PermitRootLogin no
PasswordAuthentication no
Protocol 2

# Generate keys
ssh-keygen -t ed25519
```

### SSL/TLS
```bash
# Generate certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout private.key -out certificate.crt

# Check certificate
openssl x509 -in certificate.crt -text
```

## Monitoring and Detection
### Intrusion Detection
```bash
# Check for rootkits
rkhunter --check
chkrootkit

# File monitoring
inotifywait -m -r /important/directory

# Check integrity
tripwire --check
```

### Network Monitoring
```bash
# Packet capture
tcpdump -i any port 80

# Network analysis
wireshark

# IDS
snort -A console -q -c /etc/snort/snort.conf
```

## System Hardening
### Basic Security
```bash
# Set secure permissions
chmod 600 /etc/shadow
chmod 644 /etc/passwd

# Disable unnecessary services
systemctl disable service
systemctl mask service
```

### Configuration
```bash
# Secure system settings
# /etc/sysctl.conf
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.rp_filter = 1
kernel.randomize_va_space = 2
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias chkports='netstat -tulpn'
alias chkusers='w'
alias chkauth='tail -f /var/log/auth.log'
alias seccheck='rkhunter --check'
```