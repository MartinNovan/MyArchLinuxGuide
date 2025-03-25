# User Management - Useful Commands

## User Management
### Creating Users
```bash
# Create new user
useradd user

# Create user with home directory
useradd -m user

# Create user with specific shell
useradd -m -s /bin/bash user

# Create user with description
useradd -m -c "Full Name" user
```

### Modifying Users
```bash
# Change password
passwd user

# Change shell
chsh -s /bin/bash user

# Change home directory
usermod -d /new/home user

# Lock account
usermod -L user

# Unlock account
usermod -U user
```

### Deleting Users
```bash
# Delete user
userdel user

# Delete user with home directory
userdel -r user

# Delete user and all their files
find / -user user -delete
userdel -r user
```

## Group Management
### Creating and Deleting Groups
```bash
# Create new group
groupadd group

# Delete group
groupdel group

# Create system group
groupadd -r group
```

### Managing Group Membership
```bash
# Add user to group
usermod -aG group user

# Add to multiple groups at once
usermod -aG group1,group2 user

# Remove from group
gpasswd -d user group

# Set primary group
usermod -g group user
```

## Account Information
### Viewing Information
```bash
# User information
id user

# List user groups
groups user

# Account information
finger user

# Detailed information
getent passwd user
```

### Monitoring
```bash
# Who is logged in
who
w

# Login history
last

# Failed login attempts
lastb
```

## Permissions and sudo
### Managing sudo
```bash
# Edit sudo configuration
visudo

# Add user to sudo group
usermod -aG sudo user

# Add to wheel group (on some systems)
usermod -aG wheel user
```

### Checking Permissions
```bash
# Show sudo permissions
sudo -l

# Temporarily run shell as another user
su - user

# Run command as another user
su - user -c 'command'
```

## Bulk Management
### Batch Operations
```bash
# Create multiple users from file
while IFS=: read -r user pass; do
    useradd -m "$user"
    echo "$user:$pass" | chpasswd
done < users.txt

# Delete multiple users
for user in user1 user2 user3; do
    userdel -r "$user"
done
```

### Backup and Transfer
```bash
# Backup user information
getent passwd > passwd.bak
getent group > group.bak

# Backup home directories
tar -czf home_backup.tar.gz /home/
```

## Security
### Password Checks
```bash
# Set password requirements
chage -M 90 user  # Maximum days valid
chage -m 7 user   # Minimum days between changes
chage -W 7 user   # Warning before expiration

# Force password change on next login
chage -d 0 user
```

### Audit
```bash
# Check for empty passwords
awk -F: '($2 == "") {print $1}' /etc/shadow

# Check UID 0 (root privileges)
awk -F: '($3 == "0") {print $1}' /etc/passwd

# List users with login shell
grep -v '/nologin\|/false' /etc/passwd
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias userlist='cut -d: -f1 /etc/passwd'
alias grouplist='cut -d: -f1 /etc/group'
alias sudoers='grep -Po "^%sudo.+ALL" /etc/sudoers'
```