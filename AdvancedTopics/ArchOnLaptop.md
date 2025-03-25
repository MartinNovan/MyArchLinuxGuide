# Arch Linux on Laptops

## Introduction
This document describes specific aspects of using Arch Linux on laptops, including power management, hardware troubleshooting, and optimization for mobile use.

## Basic Setup

### Power Management
```bash
sudo pacman -S tlp
sudo systemctl enable tlp
```

### Check Battery Status
```bash
upower -i /org/freedesktop/UPower/devices/battery_BAT0
```

### Power Optimization
```bash
sudo nano /etc/tlp.conf
```
```ini
CPU_SCALING_GOVERNOR_ON_BAT=powersave
CPU_SCALING_MIN_FREQ_ON_BAT=800000
CPU_SCALING_MAX_FREQ_ON_BAT=2000000
```

## Hardware

### Touchpad
```bash
sudo pacman -S xf86-input-libinput
```

### Klávesové zkratky
```bash
sudo pacman -S xbindkeys
```

### Webkamera
```bash
sudo pacman -S cheese
```

### Bluetooth
```bash
sudo pacman -S bluez bluez-utils
sudo systemctl enable bluetooth
```

## Performance Optimization

### Processor Frequency
```bash
sudo pacman -S cpupower
sudo cpupower frequency-set -g powersave
```

### GPU Acceleration
```bash
sudo pacman -S mesa
```

### Hybrid Graphics
```bash
sudo pacman -S optimus-manager
```

## Useful Tools

### Battery Monitoring
```bash
sudo pacman -S powertop
```

### Brightness Control
```bash
sudo pacman -S light
```

### Automatic Screen Off
```bash
sudo pacman -S xautolock
```

## Troubleshooting

### Non-functioning WiFi
```bash
sudo pacman -S wpa_supplicant
sudo systemctl enable wpa_supplicant@wlan0
```

### Non-functioning Sound
```bash
sudo pacman -S alsa-utils
alsamixer
```

### Issues with Hibernation
```bash
sudo nano /etc/mkinitcpio.conf
```
```ini
HOOKS=(base udev autodetect modconf block filesystems keyboard resume fsck)
```

## Recommended Practices

1. **Backup**
   - Regularly backup important files
   - Maintain a list of installed packages

2. **Monitoring**
   - Monitor battery status
   - Monitor processor temperature

3. **Maintenance**
   - Regularly update the system
   - Clean cache and temporary files

## Useful Links
- [Arch Wiki - Laptops](https://wiki.archlinux.org/title/Laptop)
- [Arch Wiki - Power management](https://wiki.archlinux.org/title/Power_management)
- [Arch Wiki - Touchpad](https://wiki.archlinux.org/title/Touchpad) 