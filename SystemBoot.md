# System Boot in Arch Linux

## Introduction
Booting is the process that starts when the computer is turned on and ends with the operating system being loaded. This document describes the entire boot process in Arch Linux.

## Boot Sequence

### 1. BIOS/UEFI
- **BIOS (Basic Input/Output System)**
  - Older system
  - Limited to 2TB disks
  - MBR partition table

- **UEFI (Unified Extensible Firmware Interface)**
  - Modern replacement for BIOS
  - GPT support
  - Secure Boot
  - Booting from large disks

### 2. Bootloader
Arch Linux supports various bootloaders:

#### GRUB
```bash
# Installation
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Configuration in /etc/default/grub
GRUB_DEFAULT=0
GRUB_TIMEOUT=5
GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=3"
```

#### systemd-boot
```bash
# Installation
bootctl install

# Configuration in /boot/loader/entries/arch.conf
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=PARTUUID=xxxx rw
```

#### EFISTUB
```bash
# Direct kernel boot via UEFI
efibootmgr --disk /dev/sda \
  --part 1 \
  --create \
  --label "Arch Linux" \
  --loader /vmlinuz-linux \
  --unicode 'root=PARTUUID=xxxx rw initrd=\initramfs-linux.img'
```

### 3. Kernel and initramfs

#### Kernel
- Core of the operating system
- Manages hardware and system resources
```bash
# Kernel installation
pacman -S linux linux-headers

# Kernel parameters in bootloader
root=PARTUUID=xxxx        # Root partition
rw                        # Read-write mount
quiet                     # Limit output
```

#### Initramfs
- Temporary root filesystem
- Contains modules and scripts for boot
```bash
# Generate initramfs
mkinitcpio -P

# Configuration in /etc/mkinitcpio.conf
MODULES=(ext4 ahci)
HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)
```

## Boot Management

### Kernel Parameters
```bash
# Common parameters
nomodeset          # Disable KMS
debug              # Verbose boot
single             # Single user mode
emergency          # Emergency shell

# Adding parameters in GRUB
GRUB_CMDLINE_LINUX_DEFAULT="parameter1 parameter2"
```

### Dual Boot
```bash
# GRUB automatically detects other OS
os-prober          # OS detection
grub-mkconfig     # Update configuration

# Manual addition in /boot/grub/custom.cfg
menuentry "Windows" {
    chainloader (hd0,1)+1
}
```

## Boot Security

### Secure Boot
```bash
# Generate keys
openssl req -new -x509 -newkey rsa:2048 -keyout MOK.key -out MOK.crt
sbsign --key MOK.key --cert MOK.crt --output vmlinuz-signed vmlinuz-linux

# Install keys
mokutil --import MOK.crt
```

### Encryption
```bash
# LUKS encryption
cryptsetup luksFormat /dev/sda2
cryptsetup open /dev/sda2 cryptroot

# /etc/crypttab
cryptroot UUID=xxx none luks

# Modify initramfs
HOOKS=(base udev autodetect keyboard keymap modconf block encrypt filesystems fsck)
```

## Troubleshooting

### Emergency Mode
```bash
# Booting to emergency shell
systemd.unit=emergency.target

# System repair
fsck /dev/sda1
mount -o remount,rw /
```

### Bootloader Recovery
```bash
# From live CD
arch-chroot /mnt
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
```

### Common Issues
1. **Kernel panic**
   - Check initramfs
   - Verify kernel parameters
   - Check root partition

2. **GRUB rescue**
   ```bash
   set prefix=(hd0,1)/boot/grub
   set root=(hd0,1)
   insmod normal
   normal
   ```

3. **Missing firmware**
   ```bash
   pacman -S linux-firmware
   mkinitcpio -P
   ```

## Optimization

### Fast Boot
```bash
# Systemd analysis
systemd-analyze
systemd-analyze blame
systemd-analyze critical-chain

# Service optimization
systemctl disable unnecessary.service
systemctl mask problematic.service
```

### Boot Scripts
```bash
# /etc/initcpio/hooks/custom
#!/bin/bash
run_hook() {
    # Custom initialization
}

# /etc/initcpio/install/custom
#!/bin/bash
build() {
    add_binary /usr/bin/custom
    add_runscript
}
```

## Maintenance

### Bootloader Update
```bash
# GRUB
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg

# systemd-boot
bootctl update
```

### Boot Partition Backup
```bash
# Backup
dd if=/dev/sda1 of=/path/to/boot_backup.img

# Restore
dd if=/path/to/boot_backup.img of=/dev/sda1
```

## Best Practices

1. **Security**
   - Use UEFI Secure Boot
   - Encrypt important partitions
   - Regularly update bootloader

2. **Maintenance**
   - Backup boot partition
   - Maintain multiple kernel versions
   - Test configuration changes

3. **Documentation**
   - Record configuration changes
   - Keep backups of configuration files
   - Document non-standard settings

## References
- [Arch Wiki - Boot process](https://wiki.archlinux.org/title/Arch_boot_process)
- [Arch Wiki - GRUB](https://wiki.archlinux.org/title/GRUB)
- [Arch Wiki - Systemd-boot](https://wiki.archlinux.org/title/Systemd-boot)

## Detailed Bootloader Configuration

### GRUB

#### Basic Configuration
```bash
# /etc/default/grub
GRUB_DEFAULT=0                     # Default entry (0 = first)
GRUB_SAVEDEFAULT=true             # Remember last selection
GRUB_TIMEOUT=5                    # Timeout in seconds
GRUB_TIMEOUT_STYLE=menu          # menu/countdown/hidden
GRUB_DISTRIBUTOR="Arch Linux"    # Distribution name
GRUB_CMDLINE_LINUX_DEFAULT=""    # Kernel parameters
GRUB_CMDLINE_LINUX=""            # Parameters for all kernels
GRUB_DISABLE_RECOVERY=false      # Show recovery options
```

#### Visual Customization
```bash
# Install GRUB Customizer
pacman -S grub-customizer

# Manual theme installation
# 1. Download theme (e.g., Vimix)
git clone https://github.com/vinceliuice/grub2-themes.git
cd grub2-themes
./install.sh -t vimix

# 2. Configuration in /etc/default/grub
GRUB_THEME="/boot/grub/themes/vimix/theme.txt"
GRUB_BACKGROUND="/boot/grub/themes/vimix/background.png"
GRUB_GFXMODE="1920x1080,auto"    # Resolution
GRUB_COLOR_NORMAL="white/black"   # Normal colors
GRUB_COLOR_HIGHLIGHT="black/white" # Highlight colors
```

#### Advanced Options
```bash
# Custom menu entries
# /etc/grub.d/40_custom
menuentry "Custom System" {
    set root=(hd0,1)
    linux /vmlinuz-linux root=/dev/sda2
    initrd /initramfs-linux.img
}

# Conditional menu
if [ "${grub_platform}" == "efi" ]; then
    menuentry "UEFI Firmware Settings" {
        fwsetup
    }
fi

# Hide menu entries
GRUB_DISABLE_OS_PROBER=true      # Disable other OS detection
```

### systemd-boot

#### Basic Configuration
```bash
# /boot/loader/loader.conf
default arch.conf     # Default configuration
timeout 3            # Timeout
console-mode max     # Console resolution
editor no           # Disable parameter editing
```

#### Entry Configuration
```bash
# /boot/loader/entries/arch.conf
title   Arch Linux
linux   /vmlinuz-linux
initrd  /amd-ucode.img  # or intel-ucode.img
initrd  /initramfs-linux.img
options root=PARTUUID=xxxx rw quiet splash

# /boot/loader/entries/arch-fallback.conf
title   Arch Linux (fallback)
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux-fallback.img
options root=PARTUUID=xxxx rw
```

#### Advanced Options
```bash
# Multiple configurations for different cases
# /boot/loader/entries/arch-debug.conf
title   Arch Linux (debug)
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=PARTUUID=xxxx rw debug

# /boot/loader/entries/arch-rescue.conf
title   Arch Linux (rescue)
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=PARTUUID=xxxx rw single
```

### GRUB vs systemd-boot

#### GRUB Advantages
- Support for multiple OS (dual boot)
- Richer configuration options
- Graphical interface and themes
- Support for older systems
- Scripting capabilities

#### systemd-boot Advantages
- Simpler configuration
- Faster boot
- Better integration with UEFI
- Smaller size
- More modern approach

### Custom Splash Screen

#### Plymouth
```bash
# Install Plymouth
pacman -S plymouth

# Configuration
# /etc/plymouth/plymouthd.conf
[Daemon]
Theme=spinner
ShowDelay=0
DeviceTimeout=5

# Enable in GRUB
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"

# Install themes
pacman -S plymouth-theme-monoarch
plymouth-set-default-theme -R monoarch
```

### Boot Animation
```bash
# GRUB animation
# /etc/default/grub
GRUB_INIT_TUNE="480 440 1"

# Custom boot logo
# Add to initramfs
# /etc/mkinitcpio.conf
MODULES=(... uvesafb)
FILES=(/path/to/logo.png)
``` 
