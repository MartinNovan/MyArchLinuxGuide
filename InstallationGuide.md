# Arch Linux Installation Guide

## Preparation

### Downloading ISO
1. Download the latest ISO from [archlinux.org](https://archlinux.org/download/)
2. Verify the ISO signature:
```bash
gpg --keyserver-options auto-key-retrieve --verify archlinux-version-x86_64.iso.sig
```

### Creating Bootable USB
```bash
# On Linux
dd bs=4M if=archlinux.iso of=/dev/sdX status=progress oflag=sync

# Or use:
# - Rufus (Windows)
# - balenaEtcher (cross-platform)
```

## Booting Live Environment

### BIOS Settings
1. Disable Secure Boot
2. Set USB as first boot device
3. Disable Fast Boot

### Internet Connection
```bash
# WiFi
iwctl
station wlan0 scan
station wlan0 get-networks
station wlan0 connect SSID

# Verify connection
ping archlinux.org
```

## Disk Preparation

### Partitioning
```bash
# Show disks
lsblk

# Create GPT partition table
gdisk /dev/sda
# or
cfdisk /dev/sda
```

#### Recommended Scheme (UEFI)
```
/dev/sda1  - EFI       (550M)  - EFI System Partition
/dev/sda2  - /boot     (1G)    - Linux filesystem
/dev/sda3  - [SWAP]    (8G)    - Linux swap
/dev/sda4  - /         (50G)   - Linux filesystem
/dev/sda5  - /home     (remainder) - Linux filesystem
```

### Formatting Partitions
```bash
# EFI partition
mkfs.fat -F32 /dev/sda1

# Boot partition
mkfs.ext4 /dev/sda2

# Swap
mkswap /dev/sda3
swapon /dev/sda3

# Root
mkfs.ext4 /dev/sda4

# Home
mkfs.ext4 /dev/sda5
```

## Basic Installation

### Mounting Partitions
```bash
# Root
mount /dev/sda4 /mnt

# Create and mount other directories
mkdir /mnt/{boot,home}
mount /dev/sda2 /mnt/boot
mount /dev/sda5 /mnt/home
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
```

### Installing Base System
```bash
# Update mirrorlist
reflector --country Czechia,Germany,Poland --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Install base packages
pacstrap /mnt base base-devel linux linux-firmware

# Basic tools
pacstrap /mnt networkmanager vim sudo
```

### Generating fstab
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

## System Configuration

### Chroot
```bash
arch-chroot /mnt
```

### Basic Settings
```bash
# Time zone
ln -sf /usr/share/zoneinfo/Europe/Prague /etc/localtime
hwclock --systohc

# Localization
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "cs_CZ.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=cs_CZ.UTF-8" > /etc/locale.conf
echo "KEYMAP=cz-qwertz" > /etc/vconsole.conf

# Hostname
echo "archlinux" > /etc/hostname
```

### Network Configuration
```bash
# /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   archlinux.localdomain archlinux

# Enable services
systemctl enable NetworkManager
```

### Users and Passwords
```bash
# Root password
passwd

# Create user
useradd -m -G wheel -s /bin/bash user
passwd user

# Sudo rights
EDITOR=vim visudo
# Uncomment: %wheel ALL=(ALL:ALL) ALL
```

### Bootloader (GRUB)
```bash
# Installation
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

# Configuration
grub-mkconfig -o /boot/grub/grub.cfg
```

## Completing Installation

### Additional Useful Packages
```bash
# Basic tools
pacman -S git wget curl

# Sound management
pacman -S pulseaudio pulseaudio-alsa pavucontrol

# Graphical environment (example with KDE)
pacman -S xorg plasma plasma-wayland-session kde-applications
systemctl enable sddm
```

### Restart
```bash
# Unmount
exit
umount -R /mnt
reboot
```

## Post-Installation

### First Steps
1. Log in to the system
2. System update:
```bash
sudo pacman -Syu
```

### Basic Setup
```bash
# AUR helper (yay)
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Firewall
sudo pacman -S ufw
sudo systemctl enable --now ufw
sudo ufw enable
```

### Graphics Drivers
```bash
# NVIDIA
sudo pacman -S nvidia nvidia-utils

# AMD
sudo pacman -S xf86-video-amdgpu

# Intel
sudo pacman -S xf86-video-intel
```

## Simplified Installation with archinstall

### Using archinstall Script
```bash
# Start interactive guide
archinstall

# Main steps:
1. Select language
2. Set keyboard (cz-qwertz)
3. Choose profile (minimal, desktop, server)
4. Set up disk (automatic or manual)
5. Select network (WiFi/Ethernet)
6. Set up user and password
7. Choose desktop environment (optional)
8. Confirm installation
```

### Advantages of archinstall
- Automation of routine tasks
- Pre-configured profiles
- Faster installation
- Suitable for beginners

### Disadvantages of archinstall
- Less flexible than manual installation
- Limited customization options
- May hide some important steps

## Preparing Keys for AUR

### Updating Keyring
```bash
# Before installation
pacman -Sy archlinux-keyring
pacman-key --init
pacman-key --populate archlinux
pacman-key --refresh-keys

# After installation
sudo pacman -S archlinux-keyring
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --refresh-keys
```

### Troubleshooting Key Issues
```bash
# If signature errors occur
sudo pacman-key --refresh-keys
sudo pacman -S archlinux-keyring
sudo pacman -Syu

# Manual key import
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys KEYID
pacman-key --recv-keys KEYID
pacman-key --lsign-key KEYID
```

### Installing from AUR
```bash
# Example yay installation
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Updating AUR packages
yay -Syu
```

## Troubleshooting

### Common Issues
1. **Cannot Boot**
   - Check GRUB configuration
   - Verify EFI settings

2. **No Internet**
   ```bash
   systemctl start NetworkManager
   nmtui
   ```

3. **No Sound**
   ```bash
   pulseaudio -k
   pulseaudio --start
   ```

## Best Practices

1. **Security**
   - Regular updates
   - Strong passwords
   - Firewall

2. **Backup**
   - Important data
   - Configuration files
   - List of installed packages

3. **Documentation**
   - Record changes
   - Keep important commands
   - Backup configuration files

## References
- [Arch Wiki - Installation guide](https://wiki.archlinux.org/title/Installation_guide)
- [Arch Wiki - General recommendations](https://wiki.archlinux.org/title/General_recommendations)
- [Arch Wiki - List of applications](https://wiki.archlinux.org/title/List_of_applications)