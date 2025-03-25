# Journalctl - Useful Commands

## Basic Usage
### Viewing Logs
```bash
# View all logs
journalctl

# View logs in real-time
journalctl -f

# View logs since last boot
journalctl -b

# View logs from previous boot
journalctl -b -1
```

### Filtering by Time
```bash
# Logs since specific date
journalctl --since="2024-01-01"

# Logs until specific date
journalctl --until="2024-01-31"

# Logs from last hour
journalctl --since "1 hour ago"

# Logs from last day
journalctl --since "1 day ago"
```

## Filtering Logs
### By Service
```bash
# Logs for specific service
journalctl -u service.service

# Logs for multiple services
journalctl -u service1.service -u service2.service

# Logs for NetworkManager
journalctl -u NetworkManager.service
```

### By Priority
```bash
# Only error messages
journalctl -p err

# Important and critical messages
journalctl -p "emerg".."crit"

# Priorities:
# 0: emerg
# 1: alert
# 2: crit
# 3: err
# 4: warning
# 5: notice
# 6: info
# 7: debug
```

## Journal Maintenance
### Maintenance
```bash
# Show journal size
journalctl --disk-usage

# Clean up old entries
journalctl --vacuum-time=2d    # Older than 2 days
journalctl --vacuum-size=1G    # Limit to 1GB

# Rotate journal
journalctl --rotate
```

### Export and Analysis
```bash
# Export to text file
journalctl > system_log.txt

# Export in JSON format
journalctl -o json > system_log.json

# Export specific service
journalctl -u service.service > service_log.txt
```

## Advanced Filtering
```bash
# Logs for specific process
journalctl _PID=1234

# Logs for specific user
journalctl _UID=1000

# Logs by executable path
journalctl _EXE=/usr/bin/program

# Combined filtering
journalctl _SYSTEMD_UNIT=sshd.service _PID=1234
```

## Output Formatting
```bash
# Compact output
journalctl --no-pager

# Output with timestamps
journalctl --output=short-precise

# Only messages without metadata
journalctl --output=cat

# Output in JSON format
journalctl --output=json
```

## Useful Combinations
```bash
# Errors since last boot
journalctl -b -p err

# Last boot in real-time
journalctl -b -f

# Errors for specific service
journalctl -u service.service -p err

# Kernel logs
journalctl -k
```

## Troubleshooting
```bash
# Verify journal integrity
journalctl --verify

# Show journal statistics
journalctl --header

# List system boots
journalctl --list-boots

# Check boot errors
journalctl -b -p err..alert
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias jctl='journalctl'
alias jctlf='journalctl -f'
alias jctlb='journalctl -b'
alias jctlerr='journalctl -p err..alert'
```