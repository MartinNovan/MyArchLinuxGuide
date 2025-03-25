# System Audit - Useful Commands

## Auditd
### Basic Configuration
```bash
# Start service
systemctl start auditd
systemctl enable auditd

# Check status
auditctl -s

# Show rules
auditctl -l
```

### Setting Rules
```bash
# File monitoring
auditctl -w /etc/passwd -p wa -k passwd_changes

# Directory monitoring
auditctl -w /etc/ssh/ -p wa -k ssh_config

# System call monitoring
auditctl -a always,exit -F arch=b64 -S execve -k exec_commands
```

## Searching Audits
### Basic Search
```bash
# Search by key
ausearch -k passwd_changes

# Search by time
ausearch -ts today
ausearch -ts recent

# Search by user
ausearch -ua root
```

### Advanced Search
```bash
# Combined search
ausearch -k passwd_changes -ts today -ua root

# System call search
ausearch -sc execve

# Search by process
ausearch -p 1234
```

## Reports
### Generating Reports
```bash
# Basic report
aureport

# Login report
aureport --login

# Command report
aureport --exec

# Modification report
aureport --file
```

### Specific Reports
```bash
# Failed report
aureport --failed

# Anomaly report
aureport --anomaly

# User report
aureport --user
```

## System Logs
### Journalctl
```bash
# Check system logs
journalctl -p err..emerg

# Logs by service
journalctl -u auditd

# Logs by time
journalctl --since "1 hour ago"
```

### Syslog
```bash
# Check auth logs
tail -f /var/log/auth.log

# Check system logs
tail -f /var/log/syslog

# Check security logs
tail -f /var/log/secure
```

## File Monitoring
### AIDE
```bash
# Initialize database
aide --init

# Check for changes
aide --check

# Update database
aide --update
```

### Tripwire
```bash
# Initialization
tripwire --init

# System check
tripwire --check

# Policy update
tripwire --update-policy
```

## Network Audit
### Tcpdump
```bash
# Capture traffic
tcpdump -i any

# Save to file
tcpdump -w capture.pcap

# Analyze file
tcpdump -r capture.pcap
```

### Wireshark
```bash
# Capture traffic
tshark

# Analyze file
tshark -r capture.pcap

# Traffic filtering
tshark -Y "http"
```

## Security Checks
### Rootkit Check
```bash
# Rkhunter check
rkhunter --check

# Chkrootkit check
chkrootkit

# Update database
rkhunter --update
```

### Integrity Check
```bash
# Package check
rpm -Va
dpkg -V

# Important file check
sha256sum -c hash.txt
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias audit-status='auditctl -s'
alias audit-rules='auditctl -l'
alias audit-report='aureport'
alias check-integrity='aide --check'
```

## Automation
```bash
# Daily audit
#!/bin/bash
date >> /var/log/daily_audit.log
auditctl -l >> /var/log/daily_audit.log
aureport --summary >> /var/log/daily_audit.log

# Change monitoring
#!/bin/bash
aide --check | mail -s "AIDE Report" admin@example.com
```