# Automation in Arch Linux

## Introduction
Automation is key to efficient system management. This document describes various tools and techniques for automating tasks in Arch Linux.

## Systemd

### Timer Units
1. Create a service:
```bash
sudo nano /etc/systemd/system/myjob.service
```
```ini
[Unit]
Description=My Custom Job

[Service]
ExecStart=/path/to/script.sh
```

2. Create a timer:
```bash
sudo nano /etc/systemd/system/myjob.timer
```
```ini
[Unit]
Description=Run My Custom Job Daily

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
```

3. Enable and start the timer:
```bash
sudo systemctl enable myjob.timer
sudo systemctl start myjob.timer
```

### Monitor Timers
```bash
systemctl list-timers
```

## Ansible

### Installation
```bash
sudo pacman -S ansible
```

### Basic Usage
1. Create inventory:
```ini
[webservers]
192.168.1.10
192.168.1.11

[dbservers]
192.168.1.20
```

2. Create playbook:
```yaml
---
- hosts: webservers
  become: yes
  tasks:
    - name: Ensure Apache is installed
      pacman:
        name: apache
        state: present
```

3. Run playbook:
```bash
ansible-playbook -i inventory playbook.yml
```

## Cron

### Basic Usage
1. Open crontab:
```bash
crontab -e
```

2. Add task:
```bash
# Every day at 3:00
0 3 * * * /path/to/script.sh
```

### Special Syntax
```bash
@reboot /path/to/script.sh
@daily /path/to/script.sh
@weekly /path/to/script.sh
```

## Shell Scripting

### Basic Script
```bash
#!/bin/bash

# Variables
BACKUP_DIR="/backups"
DATE=$(date +%F)

# Backup
tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" /important/data

# Send notification
echo "Backup completed" | mail -s "Backup $DATE" admin@example.com
```

### Automating with Scripts
1. Create script
2. Make it executable:
```bash
chmod +x script.sh
```
3. Add to cron or systemd timer

## Automating with Git

### Hooks
1. Create hook:
```bash
nano .git/hooks/post-commit
```
2. Add script:
```bash
#!/bin/bash
echo "Commit performed, running deployment..."
/path/to/deploy.sh
```

### CI/CD
1. Create pipeline:
```yaml
stages:
  - build
  - test
  - deploy

build_job:
  stage: build
  script:
    - make build

test_job:
  stage: test
  script:
    - make test
```

## Useful Tools

### Taskwarrior
```bash
sudo pacman -S task
```

### Rundeck
```bash
yay -S rundeck
```

### Jenkins
```bash
yay -S jenkins
```

## Recommended Practices

1. **Documentation**
   - Comment scripts
   - Maintain README files
   - Record changes made

2. **Testing**
   - Test scripts in isolation
   - Use virtual machines or containers
   - Implement unit tests

3. **Backup**
   - Regularly backup configuration files
   - Maintain list of automated tasks
   - Implement monitoring

## Useful Links
- [Arch Wiki - Systemd](https://wiki.archlinux.org/title/Systemd)
- [Arch Wiki - Cron](https://wiki.archlinux.org/title/Cron)
- [Ansible Documentation](https://docs.ansible.com/)
- [Git Hooks](https://git-scm.com/docs/githooks) 