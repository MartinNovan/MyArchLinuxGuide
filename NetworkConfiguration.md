# Network Configuration in Arch Linux

## Introduction
Arch Linux offers several ways to configure networking, from low-level tools to advanced network managers. This document describes various methods and their usage.

## Basic Tools

### ip (iproute2)
Modern network configuration tool:
```bash
# Show network interfaces
ip link show

# Set IP address
ip addr add 192.168.1.100/24 dev eth0

# Enable/disable interface
ip link set eth0 up
ip link set eth0 down

# Show routing table
ip route show
```

### iwctl (iwd)
WiFi management tool:
```bash
# Start interactive mode
iwctl

# Scan networks
station wlan0 scan
station wlan0 get-networks

# Connect to network
station wlan0 connect SSID
```

## NetworkManager

### Basic Usage
```bash
# Connection status
nmcli general status

# List WiFi networks
nmcli device wifi list

# Connect to WiFi
nmcli device wifi connect SSID password password

# Manage connections
nmcli connection show
nmcli connection up SSID
nmcli connection down SSID
```

### Connection Configuration
```bash
# Create static connection
nmcli connection add \
    type ethernet \
    con-name "static-eth0" \
    ifname eth0 \
    ipv4.method manual \
    ipv4.addresses 192.168.1.100/24 \
    ipv4.gateway 192.168.1.1 \
    ipv4.dns "8.8.8.8,8.8.4.4"

# Modify connection
nmcli connection modify "static-eth0" \
    ipv4.addresses 192.168.1.101/24

# Auto-connect
nmcli connection modify "static-eth0" \
    connection.autoconnect yes
```

## Systemd-networkd

### Basic Configuration
Location: `/etc/systemd/network/`

```ini
# 20-wired.network
[Match]
Name=eth0

[Network]
DHCP=yes
```

```ini
# 25-wireless.network
[Match]
Name=wlan0

[Network]
DHCP=yes
```

### Static Configuration
```ini
# 30-static.network
[Match]
Name=eth0

[Network]
Address=192.168.1.100/24
Gateway=192.168.1.1
DNS=8.8.8.8
DNS=8.8.4.4
```

## DNS Configuration

### systemd-resolved
```bash
# Enable service
systemctl enable --now systemd-resolved

# Configuration in /etc/systemd/resolved.conf
[Resolve]
DNS=8.8.8.8 8.8.4.4
FallbackDNS=1.1.1.1
Domains=~.
DNSSEC=allow-downgrade
DNSOverTLS=opportunistic
```

### /etc/resolv.conf
```bash
# Manual configuration
nameserver 8.8.8.8
nameserver 8.8.4.4
search local.domain
```

## Firewall

### UFW (Uncomplicated Firewall)
```bash
# Installation
pacman -S ufw

# Basic configuration
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow http
ufw allow https

# Enable
ufw enable
```

### iptables
```bash
# Basic rules
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport ssh -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -P INPUT DROP

# Save rules
iptables-save > /etc/iptables/iptables.rules
```

## Advanced Configuration

### Bonding (aggregation lines)
```ini
# /etc/systemd/network/bond0.netdev
[NetDev]
Name=bond0
Kind=bond

[Bond]
Mode=active-backup
MIIMonitorSec=1s
```

```ini
# /etc/systemd/network/bond0.network
[Match]
Name=bond0

[Network]
DHCP=yes
```

### VLAN
```ini
# /etc/systemd/network/vlan10.netdev
[NetDev]
Name=vlan10
Kind=vlan

[VLAN]
Id=10
```

### Bridge
```ini
# /etc/systemd/network/br0.netdev
[NetDev]
Name=br0
Kind=bridge
```

## Wireless Networks

### wpa_supplicant
```bash
# Configuration
wpa_passphrase SSID heslo > /etc/wpa_supplicant/wpa_supplicant.conf

# Start
wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf
```

### Security
```bash
# Generating strong key
wpa_passphrase SSID heslo

# Hiding SSID
nmcli connection modify SSID wifi-sec.hidden yes
```

## Diagnostics

### Basic Tools
```bash
# Ping
ping -c 4 archlinux.org

# Traceroute
traceroute archlinux.org

# DNS lookup
dig archlinux.org
nslookup archlinux.org
```

### Network Tools
```bash
# Monitoring network traffic
tcpdump -i eth0

# Port analysis
netstat -tuln
ss -tuln

# Monitoring connections
nethogs eth0
iftop -i eth0
```

## Troubleshooting

### Checklist
1. **Physical Connection**
   ```bash
   ip link show
   ethtool eth0
   ```

2. **IP Configuration**
   ```bash
   ip addr show
   ip route show
   ```

3. **DNS Resolution**
   ```bash
   ping 8.8.8.8
   dig @8.8.8.8 archlinux.org
   ```

### Common Problems
```bash
# DHCP Recovery
dhclient -r eth0
dhclient eth0

# Reset NetworkManager
systemctl restart NetworkManager

# Clearing DNS Cache
systemd-resolve --flush-caches
```

## Automation

### Scripts
```bash
# Connection Check
#!/bin/bash
if ! ping -c 1 8.8.8.8 &> /dev/null; then
    nmcli connection up "backup-connection"
    notify-send "Switched to backup connection"
fi
```

### Systemd Services
```ini
# /etc/systemd/system/network-check.service
[Unit]
Description=Network Connection Check
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/network-check.sh

[Install]
WantedBy=multi-user.target
```

## Recommended Practices

1. **Security**
   - Use strong passwords for WiFi
   - Enable firewall
   - Regularly update firmware

2. **Performance**
   - Use current drivers
   - Optimize MTU
   - Monitor network usage

3. **Maintenance**
   - Backup configuration files
   - Document changes
   - Regularly check logs

## Links
- [Arch Wiki - Network Configuration](https://wiki.archlinux.org/title/Network_configuration)
- [Arch Wiki - NetworkManager](https://wiki.archlinux.org/title/NetworkManager)
- [Arch Wiki - Wireless](https://wiki.archlinux.org/title/Wireless) 