# Network Commands - Useful Commands

## Basic Network Tools
### IP Commands
```bash
# Show network interfaces
ip addr show
ip a

# Show routing table
ip route show
ip r

# Enable/disable network interface
ip link set eth0 up
ip link set eth0 down

# Set IP address
ip addr add 192.168.1.100/24 dev eth0
```

### NetworkManager
```bash
# Show all connections
nmcli connection show

# Show active connections
nmcli connection show --active

# Connect to WiFi
nmcli device wifi connect "SSID" password "password"

# Enable/disable WiFi
nmcli radio wifi on
nmcli radio wifi off
```

## Network Diagnostics
### Ping and Traceroute
```bash
# Test connectivity
ping google.com

# Limited number of pings
ping -c 4 google.com

# Traceroute
traceroute google.com

# MTR (combination of ping and traceroute)
mtr google.com
```

### DNS Tools
```bash
# DNS lookup
nslookup google.com

# Detailed DNS information
dig google.com

# Reverse DNS lookup
dig -x 8.8.8.8

# DNS server test
dig @8.8.8.8 google.com
```

## Network Ports and Services
### Netstat and SS
```bash
# List all open ports
netstat -tuln

# List active connections
ss -tuln

# List listening TCP ports
netstat -tlnp

# List processes using network
netstat -tulnp
```

### Firewall
```bash
# Show firewall rules
iptables -L

# Show NAT rules
iptables -t nat -L

# UFW status
ufw status

# Allow port with UFW
ufw allow 80
```

## Network Utilities
### Wget and cURL
```bash
# Download file
wget https://example.com/file.zip

# Resume download
wget -c https://example.com/file.zip

# HTTP request
curl https://example.com

# POST request
curl -X POST -d "data" https://example.com
```

### SSH
```bash
# Connect to server
ssh user@server

# Copy files over SSH
scp file.txt user@server:/target/path

# Generate SSH keys
ssh-keygen -t ed25519

# Copy public key to server
ssh-copy-id user@server
```

## Network Monitoring
### Bandwidth Monitoring
```bash
# Monitor network traffic
iftop

# Monitor data transfer
nethogs

# Detailed statistics
vnstat

# Real-time statistics
vnstat -l
```

### Packet Capture
```bash
# Capture packets on interface
tcpdump -i eth0

# Capture specific port
tcpdump -i eth0 port 80

# Save to file
tcpdump -w capture.pcap
```

## Wireless Networks
### WiFi Diagnostics
```bash
# Scan available networks
iwlist wlan0 scan

# Connection information
iwconfig wlan0

# Signal strength
watch -n 1 cat /proc/net/wireless
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias myip='curl ifconfig.me'
alias ports='netstat -tuln'
alias connections='netstat -tulnp'
alias wifi='nmcli device wifi list'
```

## Troubleshooting
```bash
# Reset network interface
systemctl restart NetworkManager

# Flush DNS cache
systemd-resolve --flush-caches

# Test MTU
ping -s 1472 -M do google.com

# Check routing
ip route get 8.8.8.8
```