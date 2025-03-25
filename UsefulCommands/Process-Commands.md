# Process Management - Useful Commands

## Basic Process Operations
### Viewing Processes
```bash
# List all processes
ps aux

# Process tree
pstree

# Processes of specific user
ps -u user

# Interactive view
top
htop
```

### Process Management
```bash
# Terminate process
kill PID
kill -9 PID  # Force termination

# Terminate by name
pkill process_name
killall process_name

# Suspend process
kill -STOP PID

# Resume process
kill -CONT PID
```

## Advanced Management
### Process Priority
```bash
# Change priority (nice)
nice -n 10 command
renice 10 PID

# View processes by priority
ps -el

# Real-time priority
chrt -f 99 command
```

### Process Limits
```bash
# Set limits
ulimit -n 4096  # Number of open files
ulimit -u 100   # Number of processes

# View limits
ulimit -a

# Permanent settings in /etc/security/limits.conf
* soft nofile 4096
* hard nofile 8192
```

## Process Monitoring
### Performance Monitoring
```bash
# CPU and memory usage
ps aux --sort=-%cpu
ps aux --sort=-%mem

# I/O monitoring
iotop
iostat

# System call monitoring
strace -p PID
```

### Process Analysis
```bash
# Debug information
gdb -p PID

# View open files
lsof -p PID

# View network connections
netstat -p PID
```

## Service Management
### Systemd Services
```bash
# Service status
systemctl status service

# Start/stop service
systemctl start service
systemctl stop service

# Enable/disable on boot
systemctl enable service
systemctl disable service
```

### Traditional Init Scripts
```bash
# Start/stop service
/etc/init.d/service start
/etc/init.d/service stop

# Service status
service service status
```

## Automation
### Task Scheduling
```bash
# Run in background
nohup command &

# Run with low priority
nice command &

# Schedule with at
at now + 1 hour
at> command
```

### Cron Jobs
```bash
# Edit cron jobs
crontab -e

# List cron jobs
crontab -l

# System cron jobs
/etc/crontab
```

## Troubleshooting
### Diagnostics
```bash
# Find zombie processes
ps aux | grep Z

# Check system load
uptime
w

# Memory usage analysis
free -h
vmstat 1
```

### Critical Situations
```bash
# Terminate all user processes
pkill -u user

# Force reboot
echo b > /proc/sysrq-trigger

# View last kernel messages
dmesg | tail
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias psa='ps aux'
alias psg='ps aux | grep'
alias top10='ps aux --sort=-%cpu | head'
alias killz='kill -9'
```

## Security
```bash
# Check running services
netstat -tulpn

# Check SUID processes
find / -perm -4000 -type f

# Check processes without owner
ps aux | awk '$1 == "?"'
```