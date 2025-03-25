#!/bin/bash

# Function to convert size from kilobytes to human-readable format (GB)
convert_to_gb() {
    echo "scale=2; $1 / 1024 / 1024" | bc
}

# Get size of Pacman package cache before cleaning
pacman_cache_size_before=$(du -sk /var/cache/pacman/pkg | awk '{print $1}')

# Clean Pacman package cache
echo "Cleaning Pacman package cache..."
sudo pacman -Scc

# Get size of Pacman package cache after cleaning
pacman_cache_size_after=$(du -sk /var/cache/pacman/pkg | awk '{print $1}')

# Calculate freed space for Pacman cache
pacman_freed_space=$((pacman_cache_size_before - pacman_cache_size_after))
echo "Freed $(convert_to_gb $pacman_freed_space) GB from Pacman cache."

# Remove orphaned packages
orphans=$(pacman -Qtdq)
if [[ -n "$orphans" ]]; then
    echo "Removing orphaned packages..."
    sudo pacman -Rns $orphans
else
    echo "No orphaned packages found."
fi

# Get size of user cache before cleaning
user_cache_size_before=$(du -sk ~/.cache | awk '{print $1}')

# Clean user cache
echo "Cleaning user cache..."
rm -rf ~/.cache/*

# Get size of user cache after cleaning
user_cache_size_after=$(du -sk ~/.cache | awk '{print $1}')

# Calculate freed space for user cache
user_freed_space=$((user_cache_size_before - user_cache_size_after))
echo "Freed $(convert_to_gb $user_freed_space) GB from user cache."

# Summary
total_freed_space=$((pacman_freed_space + user_freed_space))
echo "Total freed space: $(convert_to_gb $total_freed_space) GB."

echo "Done!"
