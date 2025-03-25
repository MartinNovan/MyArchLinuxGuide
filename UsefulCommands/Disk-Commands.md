# Disk Management - Useful Commands

## Disk Information
### Viewing Disks
```bash
# List all disks and partitions
lsblk

# Detailed disk information
fdisk -l

# Filesystem information
df -h

# SMART disk information
smartctl -a /dev/sda
```

### Disk Usage
```bash
# Disk space usage
du -sh /*

# Largest directories
du -h /home | sort -rh | head -n 10

# Disk usage analysis
ncdu /
```

## Partition Management
### Creating Partitions
```bash
# Start fdisk
fdisk /dev/sda

# Start cfdisk (more user-friendly interface)
cfdisk /dev/sda

# Start parted
parted /dev/sda

# GPT partition table
gdisk /dev/sda
```

### Formatting
```bash
# Format as ext4
mkfs.ext4 /dev/sda1

# Format as BTRFS
mkfs.btrfs /dev/sda1

# Format as swap
mkswap /dev/sda2

# Format as FAT32
mkfs.fat -F32 /dev/sda1
```

## Mounting
### Basic Mounting
```bash
# Mount partition
mount /dev/sda1 /mnt

# Unmount partition
umount /mnt

# List mounted partitions
mount | column -t

# Automatic mounting (fstab)
echo "/dev/sda1 /mnt ext4 defaults 0 0" >> /etc/fstab
```

### Advanced Mounting
```bash
# Mount with specific options
mount -o rw,noexec,nosuid /dev/sda1 /mnt

# Mount ISO file
mount -o loop image.iso /mnt

# Mount network disk
mount -t cifs //server/share /mnt -o username=user
```

## RAID and LVM
### RAID Operations
```bash
# Create RAID 1
mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sda1 /dev/sdb1

# Check RAID status
cat /proc/mdstat
mdadm --detail /dev/md0

# Add disk to RAID
mdadm --add /dev/md0 /dev/sdc1
```

### LVM Management
```bash
# Create physical volume
pvcreate /dev/sda1

# Create volume group
vgcreate vg0 /dev/sda1

# Create logical volume
lvcreate -L 10G -n lv0 vg0

# Display LVM information
pvdisplay
vgdisplay
lvdisplay
```

## Backup and Recovery
### Disk Backup
```bash
# Full disk backup
dd if=/dev/sda of=/path/to/backup.img

# Compressed backup
dd if=/dev/sda | gzip > backup.img.gz

# Disk cloning
dd if=/dev/sda of=/dev/sdb status=progress
```

### Data Recovery
```bash
# Restore from backup
dd if=backup.img of=/dev/sda

# Testdisk for partition recovery
testdisk /dev/sda

# Photorec for file recovery
photorec /dev/sda
```

## Performance and Maintenance
### Performance Testing
```bash
# Read speed test
hdparm -t /dev/sda

# Disk benchmark
dd if=/dev/zero of=test bs=1M count=1000 status=progress

# FIO benchmark
fio --filename=/dev/sda --direct=1 --rw=read --bs=4k --size=1G
```

### Maintenance
```bash
# Filesystem check
fsck /dev/sda1

# TRIM for SSD
fstrim -av

# Defragmentation for ext4
e4defrag /dev/sda1

# SMART check
smartctl -t short /dev/sda
```

## Encryption
### LUKS Operations
```bash
# Create encrypted partition
cryptsetup luksFormat /dev/sda1

# Open encrypted partition
cryptsetup open /dev/sda1 cryptroot

# Close encrypted partition
cryptsetup close cryptroot

# Change password
cryptsetup luksChangeKey /dev/sda1
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias dfh='df -h'
alias duh='du -h'
alias mount='mount | column -t'
alias disks='lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT'
```

## Troubleshooting
```bash
# Disk error check
badblocks -v /dev/sda

# I/O monitoring
iotop

# Disk monitoring
iostat -x 1

# Journal check
journalctl -f
```