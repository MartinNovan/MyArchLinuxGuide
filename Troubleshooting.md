# Troubleshooting in Arch Linux

## Introduction
This document describes solutions to common problems you may encounter while using Arch Linux.

READ THIS ONLY AFTER YOU HAVE TRIED RESTARTING YOUR COMPUTER!

## Common Problems and Their Solutions

### 1. System Won't Boot
**Symptoms:**
- Black screen after boot
- Missing GRUB menu
- Kernel panic

**Solution:**
1. Try booting from a live USB
2. Chroot into the system:
```bash
mount /dev/sdX1 /mnt
mount /dev/sdX2 /mnt/boot
arch-chroot /mnt
```
3. Repair the bootloader:
```bash
grub-install /dev/sdX
grub-mkconfig -o /boot/grub/grub.cfg
```

### 2. Missing Kernel Modules
**Symptoms:**
- Network not working
- Missing drivers
- Boot errors

**Solution:**
1. Check installed modules:
```bash
lsmod
```
2. Install missing modules:
```bash
sudo pacman -S linux-headers
sudo pacman -S linux-firmware
```
3. Regenerate initramfs:
```bash
mkinitcpio -P
```

### 3. AUR Package Issues
**Symptoms:**
- Errors during AUR installation
- Missing dependencies
- Signature issues

**Solution:**
1. Update keys:
```bash
sudo pacman-key --refresh-keys
sudo pacman -S archlinux-keyring
```
2. Check dependencies:
```bash
yay -Syu
```
3. Manual installation:
```bash
git clone https://aur.archlinux.org/package.git
cd package
makepkg -si
```

### 4. Network Issues
**Symptoms:**
- WiFi/Ethernet not working
- Missing IP address
- DNS problems

**Solution:**
1. Check network status:
```bash
ip a
nmcli device status
```
2. Restart NetworkManager:
```bash
sudo systemctl restart NetworkManager
```
3. Check configuration:
```bash
cat /etc/resolv.conf
```

### 5. Sound Issues
**Symptoms:**
- No sound
- Missing devices
- Volume issues

**Solution:**
1. Check audio devices:
```bash
aplay -l
pacmd list-sinks
```
2. Restart PulseAudio:
```bash
pulseaudio -k
pulseaudio --start
```
3. Install necessary packages:
```bash
sudo pacman -S alsa-utils pulseaudio pavucontrol
```

## Useful Tools

### Systemd Journal
```bash
journalctl -xe
```

### Boot Logs
```bash
dmesg | less
```

### Filesystem Check
```bash
sudo fsck /dev/sdX1
```

### Process Monitoring
```bash
htop
```

## Best Practices

1. **Regular Backups**
   - Backup important files
   - Maintain a list of installed packages

2. **Documentation**
   - Record changes made
   - Keep important commands

3. **Testing**
   - Test major changes on a virtual machine
   - Use snapshots for quick recovery

## References
- [Arch Wiki - Troubleshooting](https://wiki.archlinux.org/title/General_troubleshooting)
- [Arch Wiki - Boot problems](https://wiki.archlinux.org/title/Arch_boot_process#Troubleshooting)
- [Arch Wiki - Network troubleshooting](https://wiki.archlinux.org/title/Network_configuration#Troubleshooting) 