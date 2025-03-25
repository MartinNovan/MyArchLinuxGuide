# Firewall - Useful Commands

## UFW (Uncomplicated Firewall)
### Basic Operations
```bash
# Enable/disable firewall
sudo ufw enable
sudo ufw disable

# Check status
sudo ufw status
sudo ufw status verbose
sudo ufw status numbered

# Reset rules
sudo ufw reset
```

### Rule Management
```bash
# Allow port
sudo ufw allow 80
sudo ufw allow 80/tcp

# Deny port
sudo ufw deny 80
sudo ufw deny 80/tcp

# Allow service
sudo ufw allow ssh
sudo ufw allow http

# Allow port range
sudo ufw allow 6000:6007/tcp
```

### Advanced Rules
```bash
# Allow from specific IP
sudo ufw allow from 192.168.1.100

# Allow on specific interface
sudo ufw allow in on eth0 to any port 80

# Allow from subnet
sudo ufw allow from 192.168.1.0/24

# Rate limiting
sudo ufw limit ssh
```

## iptables
### Basic Operations
```bash
# Show rules
sudo iptables -L
sudo iptables -L -v
sudo iptables -L --line-numbers

# Flush rules
sudo iptables -F
```

### Rule Management
```bash
# Allow port
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Deny port
sudo iptables -A INPUT -p tcp --dport 80 -j DROP

# Allow established connections
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
```

### NAT and Forwarding
```bash
# Allow forwarding
sudo iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT

# NAT rule
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Port forwarding
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
```

## firewalld
### Basic Operations
```bash
# Start/stop service
sudo systemctl start firewalld
sudo systemctl stop firewalld

# Check status
sudo firewall-cmd --state

# Reload configuration
sudo firewall-cmd --reload
```

### Zones and Services
```bash
# List zones
sudo firewall-cmd --get-zones

# Active zones
sudo firewall-cmd --get-active-zones

# Add service to zone
sudo firewall-cmd --zone=public --add-service=http

# Add port to zone
sudo firewall-cmd --zone=public --add-port=80/tcp
```

## Monitoring and Logging
### Traffic Monitoring
```bash
# Log dropped packets
sudo iptables -I INPUT 1 -j LOG

# Check logs
sudo tail -f /var/log/syslog | grep UFW
sudo tail -f /var/log/messages | grep firewalld
```

### Diagnostics
```bash
# Test connection
nc -zv localhost 80

# Check open ports
sudo netstat -tulpn
sudo ss -tulpn
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias fw='sudo ufw status verbose'
alias fwadd='sudo ufw allow'
alias fwdel='sudo ufw delete'
alias fwlist='sudo iptables -L -v --line-numbers'
```

## Common Configurations
```bash
# Basic web server
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Basic SSH server
sudo ufw allow 22/tcp

# Basic mail server
sudo ufw allow 25/tcp
sudo ufw allow 143/tcp
sudo ufw allow 993/tcp
```