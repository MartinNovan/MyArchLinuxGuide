#!/bin/bash

# Script for system update

echo "Starting system update..."

# Update mirrorlist
echo "Updating mirrorlist..."
sudo reflector --country Czechia,Germany,Poland --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Update system packages
echo "Updating system packages..."
sudo pacman -Syu --noconfirm

# Update AUR packages (if yay is installed)
if command -v yay &> /dev/null; then
    echo "Updating AUR packages..."
    yay -Syu --noconfirm
else
    echo "Yay is not installed, skipping AUR packages update."
fi

# Check for orphaned packages
orphans=$(pacman -Qtdq)
if [[ -n "$orphans" ]]; then
    echo "Found orphaned packages:"
    echo "$orphans"
    read -p "Do you want to remove them? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo pacman -Rns $orphans
    fi
else
    echo "No orphaned packages found."
fi

echo "Update completed!" 