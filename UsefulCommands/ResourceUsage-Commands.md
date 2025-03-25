# Resource Usage Monitoring - Useful Commands

## CPU Usage
### Basic Monitoring
```bash
# Basic CPU information
top
htop

# CPU load
uptime
mpstat 1

# Usage by processes
ps aux --sort=-%cpu | head

# CPU temperature
sensors
```

### Advanced Analysis
```bash
# Detailed CPU statistics
sar -u 1 5

# Usage by cores
mpstat -P ALL 1

# CPU latency
perf stat -a sleep 1

# CPU profiling
perf record -a -g sleep 10
```

## Memory Usage
### RAM Monitoring
```bash
# Basic memory information
free -h
vmstat 1

# Detailed usage
smem
ps_mem

# Top processes by memory
ps aux --sort=-%mem | head
```

### Swap Usage
```bash
# Swap information
swapon --show

# Swap usage by processes
for file in /proc/*/status ; do awk '/VmSwap|Name/{printf $2 " " $3}END{ print ""}' $file; done | sort -k 2 -n -r | head

# Clear cache
sync; echo 3 > /proc/sys/vm/drop_caches
```

## Disk Operations
### I/O Monitoring
```bash
# I/O monitoring
iostat -x 1

# I/O by processes
iotop

# Disk usage
df -h
du -sh /*
```

### I/O Analysis
```bash
# Detailed I/O statistics
pidstat -d 1

# I/O latency
ioping /dev/sda

# Disk benchmark
dd if=/dev/zero of=test bs=1M count=1000
```

## Network Resources
### Bandwidth Monitoring
```bash
# Network traffic
iftop
nethogs

# Interface statistics
ip -s link

# Detailed analysis
tcpdump -i any
```

### Network Connections
```bash
# Active connections
netstat -tulpn
ss -tuln

# Connections by process
lsof -i

# Connection statistics
netstat -s
```

## System Resources
### Overall Usage
```bash
# System statistics
dstat

# Comprehensive monitoring
atop
glances

# System load
w
uptime
```

### System Limits
```bash
# Process limits
ulimit -a

# System limits
sysctl -a

# Check limits
cat /proc/sys/fs/file-max
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias meminfo='free -h'
alias cpuinfo='mpstat 1 5'
alias diskinfo='df -h'
alias netinfo='netstat -tulpn'
```

## Automation
```bash
# Regular statistics recording
#!/bin/bash
while true; do
    date >> stats.log
    free -h >> stats.log
    mpstat 1 1 >> stats.log
    sleep 300
done

# Monitoring with alerting
#!/bin/bash
mem=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
if [ ${mem%.*} -gt 90 ]; then
    echo "High memory usage!" | mail -s "Memory Alert" admin@example.com
fi
```