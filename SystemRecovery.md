# System Recovery in Arch Linux

## Introduction
This document describes procedures for system recovery in case of serious problems or failures.

## Basic Procedures

### 1. Boot from Live USB
1. Download the latest ISO from [archlinux.org](https://archlinux.org/download/)
2. Create a bootable USB:
```bash
dd bs=4M if=archlinux.iso of=/dev/sdX status=progress oflag=sync
```
3. Boot from USB and connect to the internet

### 2. Chroot into the System
1. Find the root partition:
```bash
lsblk
```
2. Mount the partitions:
```bash
mount /dev/sdX1 /mnt
mount /dev/sdX2 /mnt/boot
mount /dev/sdX3 /mnt/home
```
3. Chroot:
```bash
arch-chroot /mnt
```

### 3. Bootloader Repair
#### GRUB
```bash
grub-install /dev/sdX
grub-mkconfig -o /boot/grub/grub.cfg
```

#### systemd-boot
```bash
bootctl install
bootctl update
```

### 4. Package Recovery
1. Check for corrupted packages:
```bash
pacman -Qkk
```
2. Repair corrupted packages:
```bash
pacman -S $(pacman -Qqn)
```

### 5. Configuration Recovery
1. Restore backed-up configuration files
2. Check important files:
```bash
/etc/fstab
/etc/mkinitcpio.conf
/etc/pacman.conf
```

## Advanced Procedures

### 1. Backup Recovery
1. Connect external storage
2. Extract the backup:
```bash
tar -xzf backup.tar.gz -C /
```
3. Restore the package list:
```bash
pacman -S - < pkglist.txt
```

### 2. RAID Recovery
1. Activate the RAID array:
```bash
mdadm --assemble --scan
```
2. Mount the RAID array:
```bash
mount /dev/md0 /mnt
```

### 3. LVM Recovery
1. Activate LVM volumes:
```bash
vgchange -ay
```
2. Mount LVM volumes:
```bash
mount /dev/vg0/root /mnt
```

## Useful Tools

### TestDisk
```bash
sudo pacman -S testdisk
testdisk
```

### Photorec
```bash
sudo pacman -S photorec
photorec
```

### GParted
```bash
sudo pacman -S gparted
gparted
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
- [Arch Wiki - System recovery](https://wiki.archlinux.org/title/System_recovery)
- [Arch Wiki - Data recovery](https://wiki.archlinux.org/title/Data_recovery)
- [Arch Wiki - Backup programs](https://wiki.archlinux.org/title/List_of_applications#Backup) 