# Arch Linux on Raspberry Pi

## Introduction
This document describes the installation and configuration of Arch Linux on Raspberry Pi. It focuses on optimization for ARM architecture and troubleshooting specific issues.

## Requirements
- Raspberry Pi (recommended 3B+ or newer)
- MicroSD card (min. 16 GB)
- Power adapter
- Ethernet cable or WiFi

## Installation

### Download Image
```bash
wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-latest.tar.gz
```

### Prepare SD Card
1. Find the device:
```bash
lsblk
```
2. Wipe the SD card:
```bash
sudo dd if=/dev/zero of=/dev/mmcblk0 bs=1M
```
3. Create partitions:
```bash
sudo fdisk /dev/mmcblk0
# Create boot partition (type W95 FAT32, 200M)
# Create root partition (type Linux)
```

### Formatting
```bash
sudo mkfs.vfat /dev/mmcblk0p1
sudo mkfs.ext4 /dev/mmcblk0p2
```

### Installation
1. Mount partitions:
```bash
sudo mount /dev/mmcblk0p2 /mnt
sudo mkdir /mnt/boot
sudo mount /dev/mmcblk0p1 /mnt/boot
```
2. Extract image:
```bash
sudo bsdtar -xpf ArchLinuxARM-rpi-latest.tar.gz -C /mnt
```
3. Sync:
```bash
sync
```

### Configuration
1. Edit fstab:
```bash
sudo nano /mnt/etc/fstab
```
2. Edit cmdline.txt:
```bash
sudo nano /mnt/boot/cmdline.txt
```

## First Boot

### Login
- User: alarm
- Password: alarm
- Root password: root

### System Update
```bash
sudo pacman -Syu
```

### Change Password
```bash
passwd
```

## Optimization

### Overclocking
```bash
sudo nano /boot/config.txt
```
```ini
over_voltage=2
arm_freq=1400
```

### Increase
```bash
gpu_mem=256
```

### Increase I/O
```bash
sudo nano /etc/fstab
```
```bash
/dev/mmcblk0p1  /boot  vfat  defaults,noatime  0  2
/dev/mmcblk0p2  /      ext4  defaults,noatime  0  1
```

## Troubleshooting

### Non-functional WiFi
```bash
sudo pacman -S wpa_supplicant
sudo systemctl enable wpa_supplicant@wlan0
```

### Non-functional Bluetooth
```bash
sudo pacman -S bluez bluez-utils
sudo systemctl enable bluetooth
```

### Low Performance
```bash
sudo pacman -S cpupower
sudo cpupower frequency-set -g performance
```

## Useful Packages

### Basic Tools
```bash
sudo pacman -S vim htop git
```

### Graphical Environment
```bash
sudo pacman -S xfce4 xfce4-goodies lightdm
sudo systemctl enable lightdm
```

### Development Tools
```bash
sudo pacman -S python nodejs
```

## Recommended Practices

1. **Backup**
   - Regularly backup the SD card
   - Maintain a list of installed packages

2. **Monitoring**
   - Monitor CPU temperature
   - Monitor memory usage

3. **Maintenance**
   - Regularly update the system
   - Clean cache and temporary files

## Useful Links
- [Arch Linux ARM](https://archlinuxarm.org/)
- [Raspberry Pi Documentation](https://www.raspberrypi.org/documentation/)
- [Arch Wiki - Raspberry Pi](https://wiki.archlinux.org/title/Raspberry_Pi) 