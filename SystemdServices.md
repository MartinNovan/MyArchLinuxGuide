# Systemd Services and System Management

## What is systemd?
Systemd is a system for initializing and managing services in modern Linux systems. It replaces the traditional init system and provides:
- Parallel service startup
- On-demand service activation
- Process tracking
- Device connection management
- Log management

## Basic Concepts

### Units
Systemd uses different types of units for system management:

1. **Service Units (.service)**
   - Management of services and daemons
   - Example: sshd.service, nginx.service

2. **Socket Units (.socket)**
   - Network sockets and IPC
   - Service activation based on connections
   - Example: cups.socket

3. **Mount Units (.mount)**
   - Management of mounted file systems
   - Example: home.mount

4. **Timer Units (.timer)**
   - Task scheduling (alternative to cron)
   - Example: backup.timer

5. **Target Units (.target)**
   - Groups of units
   - Define system states
   - Example: multi-user.target

### Service States
- **active (running)** - Service is running
- **active (exited)** - Service successfully completed
- **failed** - Service failed
- **inactive** - Service is not running
- **enabled** - Service starts at boot
- **disabled** - Service does not start at boot

## Service Management

### Basic Commands
```bash
# Start service
systemctl start service.service

# Stop service
systemctl stop service.service

# Restart service
systemctl restart service.service

# Reload configuration
systemctl reload service.service

# Service status
systemctl status service.service
```

### Automatic Startup
```bash
# Enable service at boot
systemctl enable service.service

# Disable service at boot
systemctl disable service.service

# Enable and start immediately
systemctl enable --now service.service

# Disable and stop immediately
systemctl disable --now service.service
```

## Service Configuration

### Unit Locations
- `/usr/lib/systemd/system/` - System units
- `/etc/systemd/system/` - User units
- `/run/systemd/system/` - Runtime units

### Anatomy of a Service File
```ini
[Unit]
Description=Service description
After=network.target
Requires=some.service

[Service]
Type=simple
ExecStart=/usr/bin/program
ExecStop=/usr/bin/program stop
Restart=always
User=nobody
Group=nobody

[Install]
WantedBy=multi-user.target
```

### Service Types
- **simple** - Main process is started directly
- **forking** - Service forks
- **oneshot** - One-time execution
- **notify** - Service signals readiness
- **dbus** - Service registers on D-Bus

## Advanced Features

### Service Dependencies
```ini
[Unit]
# Must run before this service
Before=another.service

# Must run after this service
After=previous.service

# Requires this service to run
Requires=required.service

# Recommends this service to run
Wants=optional.service

# Conflicts with this service
Conflicts=conflicting.service
```

### Restart Policies
```ini
[Service]
# Always restart
Restart=always

# Restart only on failure
Restart=on-failure

# Never restart
Restart=no

# Restart timeout
RestartSec=5s
```

### Resource Limits
```ini
[Service]
# CPU limit
CPUQuota=50%

# Memory limit
MemoryLimit=1G

# I/O limit
IOWeight=100
```

## Logging and Diagnostics

### Journald
```bash
# View service logs
journalctl -u service.service

# Follow logs in real time
journalctl -u service.service -f

# Logs since last boot
journalctl -u service.service -b

# Logs from the last hour
journalctl -u service.service --since "1 hour ago"
```

### Troubleshooting
```bash
# Check dependencies
systemctl list-dependencies service.service

# List failed services
systemctl --failed

# Detailed status
systemctl status service.service -l

# Analyze boot process
systemd-analyze blame
```

## User Services

### Managing User Services
```bash
# Start user service
systemctl --user start service.service

# Status of user service
systemctl --user status service.service

# Enable user service
systemctl --user enable service.service
```

### User Unit Locations
- `~/.config/systemd/user/` - User units
- `/usr/lib/systemd/user/` - System user units

## Security

### Service Isolation
```ini
[Service]
# Chroot isolation
RootDirectory=/var/lib/service

# File access restrictions
ProtectSystem=strict
ProtectHome=true

# Network access restrictions
PrivateNetwork=true

# Privilege restrictions
CapabilityBoundingSet=CAP_NET_BIND_SERVICE
```

### Best Practices
1. **Least Privilege**
   - Use dedicated users
   - Restrict system access
   - Define clear dependencies

2. **Monitoring**
   - Monitor service logs
   - Set up failure alerts
   - Regularly check status

3. **Maintenance**
   - Regularly update configurations
   - Clean old logs
   - Test service restarts

## Useful Tips

### Bash/Zsh Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias scs='systemctl status'
alias scr='systemctl restart'
alias scf='systemctl --failed'
alias jc='journalctl -xe'
```

### Automation
```bash
# Script to restart service on failure
#!/bin/bash
if ! systemctl is-active --quiet service.service; then
    systemctl restart service.service
    notify-send "Service restarted"
fi
```

## References
- [Arch Wiki - Systemd](https://wiki.archlinux.org/title/Systemd)
- [Systemd documentation](https://www.freedesktop.org/software/systemd/man/)