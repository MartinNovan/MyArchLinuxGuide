#!/bin/bash

# Script for backing up important files

# Basic variables
BACKUP_DIR="$HOME/backups"
DATE=$(date +%F)
BACKUP_NAME="backup_$DATE.tar.gz"
CONFIG_FILES=(
    "$HOME/.bashrc"
    "$HOME/.zshrc"
    "$HOME/.vimrc"
    "$HOME/.tmux.conf"
    "$HOME/.gitconfig"
    "$HOME/.config/"
    "/etc/pacman.conf"
    "/etc/fstab"
)

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Backup configuration files
echo "Backing up configuration files..."
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "${CONFIG_FILES[@]}"

# Backup list of installed packages
echo "Backing up list of installed packages..."
pacman -Qqe > "$BACKUP_DIR/pkglist_$DATE.txt"

# Backup AUR packages (if yay is installed)
if command -v yay &> /dev/null; then
    echo "Backing up list of AUR packages..."
    yay -Qqm > "$BACKUP_DIR/aurlist_$DATE.txt"
fi

# Check backup size
BACKUP_SIZE=$(du -h "$BACKUP_DIR/$BACKUP_NAME" | awk '{print $1}')
echo "Backup successfully created: $BACKUP_DIR/$BACKUP_NAME ($BACKUP_SIZE)"

# Reminder to store the backup
echo "Don't forget to store the backup on external storage!" 