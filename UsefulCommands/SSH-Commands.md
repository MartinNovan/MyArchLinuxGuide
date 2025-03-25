# SSH - Useful Commands

## Basic SSH Operations
### Connection
```bash
# Basic connection
ssh user@server

# Connect to specific port
ssh -p 2222 user@server

# Connect with verbose output
ssh -v user@server

# Connect with specific key
ssh -i ~/.ssh/my_key user@server
```

### Key Management
```bash
# Generate SSH key
ssh-keygen -t ed25519
ssh-keygen -t rsa -b 4096

# Copy public key to server
ssh-copy-id user@server

# Check key fingerprints
ssh-keygen -lf ~/.ssh/id_ed25519.pub
```

## File Transfer
### SCP (Secure Copy)
```bash
# Copy file to server
scp file.txt user@server:/target/path/

# Copy directory to server
scp -r directory/ user@server:/target/path/

# Copy from server
scp user@server:/remote/file.txt ./

# Copy between servers
scp user@server1:/file.txt user@server2:/target/path/
```

### SFTP
```bash
# Connect to SFTP
sftp user@server

# Basic SFTP commands
put file.txt    # Upload file
get file.txt    # Download file
ls              # List files
cd              # Change directory
pwd             # Current directory
```

## Advanced SSH Features
### Tunneling
```bash
# Local port forwarding
ssh -L 8080:localhost:80 user@server

# Remote port forwarding
ssh -R 8080:localhost:80 user@server

# Dynamic port forwarding (SOCKS proxy)
ssh -D 1080 user@server
```

### SSH Agent
```bash
# Start SSH agent
eval $(ssh-agent)

# Add key to agent
ssh-add ~/.ssh/id_ed25519

# List keys in agent
ssh-add -l

# Remove all keys
ssh-add -D
```

## Configuration
### SSH Config
```bash
# ~/.ssh/config
Host server
    HostName server.example.com
    User user
    Port 2222
    IdentityFile ~/.ssh/special_key

# Use configuration
ssh server
```

### Security
```bash
# /etc/ssh/sshd_config
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
Port 2222
```

## Maintenance and Diagnostics
### Troubleshooting
```bash
# Test SSH connection
ssh -T git@github.com

# Debug mode
ssh -vvv user@server

# Check SSH service
sudo systemctl status sshd
```

### Known Hosts Management
```bash
# Remove old key
ssh-keygen -R server.example.com

# Check known hosts
cat ~/.ssh/known_hosts

# Scan host key
ssh-keyscan server.example.com
```

## Automation
### Passwordless SSH
```bash
# Generate key without password
ssh-keygen -t ed25519 -N ""

# Automatic login
cat ~/.ssh/id_ed25519.pub | ssh user@server "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

### Running Commands
```bash
# Remote command execution
ssh user@server 'ls -la'

# Run multiple commands
ssh user@server 'cd /var/log && tail -f syslog'

# Run sudo command
ssh user@server 'sudo systemctl restart nginx'
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias ssha='eval $(ssh-agent) && ssh-add'
alias sshk='ssh-keygen -t ed25519'
alias sshc='ssh-copy-id'
alias ssht='ssh -T'
```