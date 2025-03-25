# System Monitoring - Useful Commands

## Basic Monitoring
### System Information
```bash
# Basic system information
uname -a

# CPU information
lscpu
cat /proc/cpuinfo

# Memory information
free -h
cat /proc/meminfo

# Disk information
df -h
```

### Real-time Monitoring
```bash
# Basic system monitor
top

# Enhanced monitor (htop)
htop

# CPU and memory monitoring
vmstat 1

# I/O monitoring
iostat -x 1
```

## Advanced Monitoring
### Graphical Tools
```bash
# System monitor
gnome-system-monitor

# Network monitoring
iftop
nethogs

# Disk monitoring
iotop
```

### Performance Tools
```bash
# Performance statistics
mpstat 1

# Disk latency
iostat -dx 1

# CPU usage by cores
mpstat -P ALL 1
```

## Logging and Analysis
### System Logs
```bash
# Monitor system logs
journalctl -f

# Kernel logs
dmesg
dmesg -w

# System statistics
sar -u 1 5
```

### Performance Analysis
```bash
# Process performance analysis
pidstat 1

# Memory usage analysis
smem

# Swap usage analysis
swapon --show
```

## Network Monitoring
### Network Statistics
```bash
# Network connections
netstat -tulpn

# Active connections
ss -tuln

# Bandwidth monitoring
bmon
```

### Network Analysis
```bash
# Network traffic monitoring
tcpdump -i any
wireshark

# Network interface statistics
ip -s link
```

## Process Monitoring
### Process Management
```bash
# List processes
ps aux

# Process tree
pstree

# Monitor process changes
watch -n 1 'ps aux'
```

### Process Analysis
```bash
# Detailed process information
ps -p PID -f

# Monitor specific process
top -p PID

# CPU usage by processes
ps -eo pid,ppid,%cpu,%mem,cmd --sort=-%cpu
```

## Resource Monitoring
### CPU Usage
```bash
# CPU load
uptime
w

# CPU temperature
sensors

# CPU frequency
watch -n 1 'cat /proc/cpuinfo | grep MHz'
```

### Memory Usage
```bash
# Detailed memory usage
ps_mem

# Cache and buffer
sync; echo 3 > /proc/sys/vm/drop_caches

# Top memory consumers
ps aux --sort=-%mem | head
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias mem='free -h'
alias cpu='mpstat 1 5'
alias io='iostat -x 1 5'
alias net='netstat -tulpn'
alias watch-cpu='watch -n 1 "mpstat 1 1"'
```

## Automation
```bash
# Regular statistics recording
sar -o /tmp/system_stats 1 3600

# Automatic monitoring with cron
* * * * * /usr/bin/vmstat >> /var/log/vmstat.log

# Monitoring with alerting
#!/bin/bash
mem=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
if [ ${mem%.*} -gt 90 ]; then
    echo "High memory usage!" | mail -s "Memory Alert" admin@example.com
fi
```