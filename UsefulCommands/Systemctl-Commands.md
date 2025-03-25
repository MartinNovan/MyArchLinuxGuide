# Systemctl - Useful Commands

## Service Management
### Basic Service Operations
```bash
# Start service
systemctl start service.service

# Stop service
systemctl stop service.service

# Restart service
systemctl restart service.service

# Reload service configuration
systemctl reload service.service

# Check service status
systemctl status service.service
```

### Automatic Startup
```bash
# Enable service on boot
systemctl enable service.service

# Disable service on boot
systemctl disable service.service

# Enable and start immediately
systemctl enable --now service.service

# Disable and stop immediately
systemctl disable --now service.service
```

## System Operations
### System Management
```bash
# Reboot system
systemctl reboot

# Shutdown system
systemctl poweroff

# Suspend system
systemctl suspend

# Hibernate system
systemctl hibernate
```

### System Check
```bash
# List all units
systemctl list-units

# List only active units
systemctl list-units --state=active

# List failed units
systemctl list-units --state=failed

# List all services
systemctl list-units --type=service
```

## Analysis and Troubleshooting
### Diagnostics
```bash
# Show service dependencies
systemctl list-dependencies service.service

# Show configuration file
systemctl cat service.service

# Show service properties
systemctl show service.service

# Check if service is active
systemctl is-active service.service

# Check if service is enabled
systemctl is-enabled service.service
```

### Service Logs
```bash
# Show service logs
journalctl -u service.service

# Show service logs in real-time
journalctl -u service.service -f

# Show service logs since last boot
journalctl -u service.service -b
```

## Timer Management
```bash
# List all timers
systemctl list-timers

# Start timer
systemctl start timer.timer

# Enable timer
systemctl enable timer.timer

# Check timer status
systemctl status timer.timer
```

## Network Services
```bash
# Restart network interface
systemctl restart NetworkManager

# Check firewall status
systemctl status firewalld

# Restart SSH service
systemctl restart sshd
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias sstart='sudo systemctl start'
alias sstop='sudo systemctl stop'
alias srestart='sudo systemctl restart'
alias sstatus='systemctl status'
alias senable='sudo systemctl enable'
alias sdisable='sudo systemctl disable'
```

## Troubleshooting Tips
```bash
# Show all failures since last boot
systemctl --failed

# Check system resource usage
systemd-cgtop

# Reset failed service
sudo systemctl reset-failed service.service

# Mask problematic service
sudo systemctl mask problematic.service
```