# Post-installation Setup for Arch Linux

## Introduction
After a successful installation of Arch Linux, several steps are needed to optimize and customize the system. This guide covers the most important post-installation tasks.

> **Note:** If you used `archinstall`, many of these steps may already be configured. Still, we recommend checking and adjusting the configuration if necessary.

## Basic Setup

### Check for Updates
```bash
sudo pacman -Syu
```

### Check Time Zone
```bash
timedatectl status
# If incorrect:
sudo timedatectl set-timezone Europe/Prague
sudo timedatectl set-ntp true
```

### Check Localization
```bash
locale
# If incorrect:
sudo sed -i 's/#cs_CZ.UTF-8 UTF-8/cs_CZ.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen
echo "LANG=cs_CZ.UTF-8" | sudo tee /etc/locale.conf
```

## User Settings

### Check Groups
```bash
groups
# If important groups are missing:
sudo usermod -aG wheel,audio,video,storage,optical,network user
```

### Check Sudo
```bash
sudo -l
# If not set up:
sudo EDITOR=vim visudo
# Uncomment: %wheel ALL=(ALL:ALL) ALL
```

## Network Settings

### Check NetworkManager
```bash
nmcli general status
# If not active:
sudo systemctl enable --now NetworkManager
```

### Check Firewall
```bash
sudo ufw status
# If not set up:
sudo pacman -S ufw
sudo ufw enable
sudo systemctl enable ufw
```

## Graphical Environment

### Check Graphics Drivers
```bash
lspci -k | grep -EA3 'VGA|3D|Display'
# Install missing drivers:
# NVIDIA
sudo pacman -S nvidia nvidia-utils nvidia-settings

# AMD
sudo pacman -S xf86-video-amdgpu

# Intel
sudo pacman -S xf86-video-intel
```

## Multimedia

### Check Sound
```bash
pactl info
# If not set up:
sudo pacman -S pulseaudio pulseaudio-alsa pavucontrol
```

## Development Tools

### Basic Tools
```bash
sudo pacman -S git vim base-devel
```

## AUR and yay

### Install yay
```bash
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
fi
```

## Optimization

### Check TRIM for SSD
```bash
systemctl status fstrim.timer
# If not active:
sudo systemctl enable fstrim.timer
```

## Security

### Update Keys
```bash
sudo pacman-key --refresh-keys
sudo pacman -S archlinux-keyring
```

## Useful Applications

### Basic Tools
```bash
sudo pacman -S firefox thunderbird libreoffice-fresh vlc gimp
```

## Best Practices

1. **Backup**
   - Important data
   - Configuration files
   - List of packages

2. **Documentation**
   - Record changes
   - Keep important commands
   - Backup configuration files

3. **Maintenance**
   - Regular updates
   - System cleaning
   - Performance monitoring

## References
- [Arch Wiki - General recommendations](https://wiki.archlinux.org/title/General_recommendations)
- [Arch Wiki - List of applications](https://wiki.archlinux.org/title/List_of_applications)
- [Arch Wiki - AUR helpers](https://wiki.archlinux.org/title/AUR_helpers) 