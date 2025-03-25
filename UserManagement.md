# User Management in Arch Linux

## Introduction
User management is a key part of Linux system administration. It involves creating and managing user accounts, groups, and permissions.

## Basic Concepts

### Users
- **root** - Superuser with full privileges
- **system users** - Accounts for services (UID < 1000)
- **regular users** - Normal user accounts (UID >= 1000)

### Groups
- **primary group** - User's main group
- **secondary groups** - Additional groups for access rights

### Important Files
```bash
/etc/passwd   # User database
/etc/shadow   # Encrypted passwords
/etc/group    # Group database
/etc/gshadow  # Encrypted group passwords
```

## User Management

### Creating Users
```bash
# Basic user creation
useradd -m -G wheel,audio,video user

# Creation with additional parameters
useradd -m -G wheel,audio,video -s /bin/bash -c "Full Name" user

# Creating a system user
useradd -r -s /usr/bin/nologin service
```

### Modifying Users
```bash
# Changing groups
usermod -aG group user

# Changing shell
usermod -s /bin/zsh user

# Changing home directory
usermod -d /new/home user

# Locking account
usermod -L user

# Unlocking account
usermod -U user
```

### Deleting Users
```bash
# Deleting a user
userdel user

# Deleting including home directory
userdel -r user

# Backup before deletion
tar -czf user-backup.tar.gz /home/user
userdel -r user
```

## Group Management

### Creating Groups
```bash
# Creating a new group
groupadd group

# Creating a system group
groupadd -r group

# Creating with specific GID
groupadd -g 1500 group
```

### Modifying Groups
```bash
# Adding a user to a group
gpasswd -a user group

# Removing a user from a group
gpasswd -d user group

# Changing group name
groupmod -n new_group old_group
```

### Deleting Groups
```bash
# Deleting a group
groupdel group
```

## Permissions

### Basic Permissions
```bash
# Changing owner
chown user:group file

# Changing permissions
chmod 755 file  # rwxr-xr-x
chmod u+x file  # Adding execute permission for owner

# Recursive change
chown -R user:group /directory
chmod -R 755 /directory
```

### Special Permissions
```bash
# SUID (run with owner's privileges)
chmod u+s file  # or chmod 4755 file

# SGID (run with group's privileges)
chmod g+s directory  # or chmod 2755 directory

# Sticky bit (only owner can delete)
chmod +t directory  # or chmod 1755 directory
```

## ACL (Access Control Lists)

### Basic Usage
```bash
# Setting ACL
setfacl -m u:user:rwx file
setfacl -m g:group:rx file

# Viewing ACL
getfacl file

# Removing ACL
setfacl -b file
```

### Advanced ACL
```bash
# Default ACL for new files
setfacl -d -m u:user:rwx directory

# Copying ACL
getfacl source | setfacl --set-file=- target
```

## Sudo Configuration

### Basic Setup
```bash
# /etc/sudoers
# Edit using visudo!

# Allowing wheel group
%wheel ALL=(ALL:ALL) ALL

# Passwordless for specific commands
user ALL=(ALL) NOPASSWD: /usr/bin/pacman -Syu
```

### Advanced Configuration
```bash
# Command restrictions
user ALL=(ALL) /usr/bin/systemctl restart apache

# Aliases
Cmnd_Alias UPDATE = /usr/bin/pacman -Syu
user ALL=(ALL) UPDATE
```

## Security

### Password Policy
```bash
# /etc/security/pwquality.conf
minlen = 12
minclass = 4
maxrepeat = 3
```

### Access Restrictions
```bash
# /etc/security/access.conf
+ : root : ALL
+ : @wheel : ALL
- : ALL : ALL
```

### Resource Limits
```bash
# /etc/security/limits.conf
@users soft nproc 1000
@users hard nproc 2000
```

## Automation

### Management Scripts
```bash
#!/bin/bash
# Creating a new user with standard configuration
create_user() {
    useradd -m -G wheel,audio,video -s /bin/bash "$1"
    passwd "$1"
    mkdir -p /home/"$1"/.config
    chown -R "$1":"$1" /home/"$1"
}
```

### Bulk Operations
```bash
#!/bin/bash
# Adding all users to a new group
for user in $(awk -F: '$3 >= 1000 {print $1}' /etc/passwd); do
    usermod -aG newgroup "$user"
done
```

## Monitoring

### Activity Tracking
```bash
# Currently logged-in users
who
w

# Login history
last
lastlog

# Monitoring changes in /etc/passwd
ausearch -f /etc/passwd
```

### Auditing
```bash
# Setting up auditing
auditctl -w /etc/passwd -p wa -k user-modify
auditctl -w /etc/group -p wa -k group-modify

# Checking logs
aureport --auth
```

## Best Practices

1. **Security**
   - Regular password changes
   - Permission checks
   - User account audits

2. **Organization**
   - Consistent naming
   - Documentation of changes
   - Regular reviews

3. **Automation**
   - Scripting routine tasks
   - Automatic backups
   - Change monitoring

## User Types

### Root User
- **UID 0**
- Has absolute control over the system
- Can change anything in the system
- Not restricted by any permissions
- **Security Recommendations:**
  - Do not use for regular work
  - Access only via sudo
  - Disable direct SSH login

### System Users
- **UID 1-999**
- Created automatically during service installation
- Do not have an interactive shell
- Examples:
  - `http` - for web server
  - `mysql` - for database server
  - `nginx` - for NGINX server
  - `git` - for Git services
- **Purpose:**
  - Service isolation
  - Limiting access to system resources
  - Increasing security

### Regular Users
- **UID 1000+**
- Intended for real people
- Have an interactive shell
- Limited permissions
- **Recommendations:**
  - Create for each individual
  - Set strong passwords
  - Regularly review permissions

## System Groups and Their Usage

### Basic System Groups
- **root (GID 0)**
  - Administrative group
  - Full system access

- **wheel**
  - Users with sudo privileges
  - ```bash
    # Adding a user to wheel
    usermod -aG wheel user
    ```

- **users**
  - Standard group for regular users
  - Basic access to shared files

### Hardware Groups
- **audio**
  - Access to audio devices
  - Necessary for sound playback

- **video**
  - Access to graphics devices
  - Required for hardware acceleration

- **input**
  - Access to input devices
  - Mouse, keyboard, joysticks

- **storage**
  - Access to storage devices
  - Ability to mount/unmount disks

### Network Groups
- **network**
  - Management of network interfaces
  - ```bash
    # Allowing network management
    usermod -aG network user
    ```

- **wireshark**
  - Access to network sniffing
  - Necessary for network traffic analysis

### System Services
- **docker**
  - Access to Docker daemon
  - ```bash
    # Allowing Docker usage
    usermod -aG docker user
    ```

- **vboxusers**
  - For working with VirtualBox
  - Access to USB devices in VM

### Managing Group Permissions

#### Recommended Settings
```bash
# Creating a shared group for a project
groupadd project
usermod -aG project user1
usermod -aG project user2

# Setting up a shared directory
mkdir /srv/project
chown :project /srv/project
chmod 2775 /srv/project  # SGID bit for group inheritance
```

#### Group Hierarchy
```bash
# Developer groups
groupadd developers
groupadd frontend-dev
groupadd backend-dev

# Adding subgroups
usermod -aG developers,frontend-dev frontend-user
usermod -aG developers,backend-dev backend-user
```

### Managing Project Groups

#### Creating Project Structure
```bash
#!/bin/bash
create_project_structure() {
    local project=$1
    local group=$2
    
    # Create group
    groupadd $group
    
    # Create directory structure
    mkdir -p /srv/projects/$project/{src,docs,data}
    
    # Set permissions
    chown -R :$group /srv/projects/$project
    chmod -R 2775 /srv/projects/$project
    
    # Set ACL for future files
    setfacl -d -m g::rwx /srv/projects/$project
}
```

#### Automatic Membership Management
```bash
#!/bin/bash
# Script for managing group membership
manage_project_access() {
    local user=$1
    local project=$2
    local access_level=$3
    
    case $access_level in
        "read")
            setfacl -m u:$user:rx /srv/projects/$project
            ;;
        "write")
            setfacl -m u:$user:rwx /srv/projects/$project
            usermod -aG project-$project $user
            ;;
        "admin")
            usermod -aG project-$project-admin $user
            ;;
    esac
}
``` 

## References
- [Arch Wiki - Users and groups](https://wiki.archlinux.org/title/Users_and_groups)
- [Arch Wiki - Sudo](https://wiki.archlinux.org/title/Sudo)
- [Arch Wiki - Security](https://wiki.archlinux.org/title/Security)
