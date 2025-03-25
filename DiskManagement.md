# Disk Management in Arch Linux

## Introduction
Disk management is a crucial part of system administration. It involves working with physical disks, partitions, file systems, and their monitoring.

## File Systems - Overview and Comparison

### ext4
**Advantages:**
- Stable and time-tested
- Good performance for regular use
- Easy data recovery
- Low fragmentation
- Fast system checks

**Disadvantages:**
- Lacks advanced features (snapshots, compression)
- Limited scalability
- Maximum file size 16TB
- No deduplication support

**Recommended use:**
- System partitions
- Regular user systems
- Servers requiring stability

### btrfs
**Advantages:**
- Integrated snapshots
- On-the-fly data compression
- RAID support
- Data integrity checking
- Dynamic partition management
- Subvolumes (similar to LVM)

**Disadvantages:**
- Higher CPU usage with compression
- More complex management
- RAID 5/6 not recommended for production
- Higher RAM consumption

**Recommended use:**
- Home systems
- Systems requiring snapshots
- Systems with limited space (thanks to compression)

### XFS
**Advantages:**
- Excellent performance for large files
- Good scalability
- Stable under high load
- Fast crash recovery

**Disadvantages:**
- Cannot shrink partition
- Worse performance with small files
- No snapshot support
- More complex file recovery

**Recommended use:**
- Server systems
- Media storage
- Database servers

### ZFS
**Advantages:**
- Advanced data protection
- Integrated RAID (RAIDZ)
- Compression and deduplication
- Snapshots and clones
- Self-healing capabilities

**Disadvantages:**
- High RAM consumption
- Licensing limitations
- More complex installation on Linux
- Not in mainline kernel

**Recommended use:**
- NAS systems
- Critical data storage
- Enterprise servers

### F2FS
**Advantages:**
- Optimized for SSD and flash
- Lower SSD wear
- Good performance for small files
- Fast mount/umount

**Disadvantages:**
- Fewer management tools
- Limited support in some systems
- Younger system with less experience

**Recommended use:**
- SSD drives
- Mobile devices
- Embedded systems

### Performance Comparison
```bash
# Sequential read (MB/s)
ext4:   250
btrfs:  245 (no compression)
xfs:    255
zfs:    240

# Random I/O (IOPS)
ext4:   8000
btrfs:  7500
xfs:    8200
zfs:    7800
```

### Recommended Configurations

#### Desktop System
```bash
# Root (/)
Filesystem: ext4 or btrfs
Options: noatime,discard=async

# Home (/home)
Filesystem: btrfs
Options: noatime,compress=zstd,discard=async

# Swap
Filesystem: swap
Options: pri=100
```

#### Server
```bash
# Root (/)
Filesystem: ext4
Options: noatime,errors=remount-ro

# Data (/var)
Filesystem: XFS
Options: noatime,nodiratime

# Logs (/var/log)
Filesystem: ext4
Options: noatime,nodiratime
```

#### NAS/Storage
```bash
# Data storage
Filesystem: ZFS or btrfs
Options: compress=zstd,nodatacow (for databases)
```

## Basic Concepts

### Disk Types
- **HDD** - Traditional hard drives
- **SSD** - Solid State Drive
- **NVMe** - Fast SSD via PCIe
- **eMMC** - Embedded flash memory

### Device Naming
- **/dev/sdX** - SATA/USB disks
- **/dev/nvmeXnY** - NVMe disks
- **/dev/mmcblkX** - eMMC/SD cards

## Partition Management

### Partition Tables
#### GPT (GUID Partition Table)
```bash
# Create GPT table
gdisk /dev/sda
# or
parted -s /dev/sda mklabel gpt

# Show partitions
gdisk -l /dev/sda
```

#### MBR (Master Boot Record)
```bash
# Create MBR table
fdisk /dev/sda
# or
parted -s /dev/sda mklabel msdos
```

### Partition Management Tools

#### fdisk
```bash
# Interactive mode
fdisk /dev/sda

# Common commands
n    # new partition
d    # delete partition
t    # change type
w    # write changes
```

#### parted
```bash
# Create partition
parted /dev/sda mkpart primary ext4 1MiB 100GiB

# Resize
parted /dev/sda resizepart 1 120GiB

# Check
parted /dev/sda print
```

## File Systems

### File System Types

#### ext4
```bash
# Create
mkfs.ext4 /dev/sda1

# Tuning
tune2fs -c 30 /dev/sda1  # Mounts between checks
tune2fs -L "ROOT" /dev/sda1  # Set label
```

#### btrfs
```bash
# Create
mkfs.btrfs /dev/sda1

# Subvolumes
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home

# Snapshots
btrfs subvolume snapshot /mnt/@ /mnt/@snapshot
```

#### XFS
```bash
# Create
mkfs.xfs /dev/sda1

# Management
xfs_repair /dev/sda1
xfs_fsr /dev/sda1  # Defragmentation
```

### Mounting

#### Basic Mounting
```bash
# Manual mounting
mount /dev/sda1 /mnt

# Automatic mounting (/etc/fstab)
/dev/sda1  /         ext4    defaults,noatime  0 1
/dev/sda2  /home     ext4    defaults,noatime  0 2
```

#### Advanced Options
```bash
# Mounting with options
mount -o noatime,compress=zstd /dev/sda1 /mnt

# Bind mount
mount --bind /source /target
```

## RAID and LVM

### Software RAID (mdadm)
```bash
# Create RAID 1
mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sda1 /dev/sdb1

# Monitoring
mdadm --detail /dev/md0
mdadm --monitor --scan --daemonize

# Recovery
mdadm /dev/md0 --add /dev/sdc1
```

### LVM (Logical Volume Management)

#### Physical Volumes (PV)
```bash
# Create PV
pvcreate /dev/sda1 /dev/sdb1

# Display
pvdisplay
pvs
```

#### Volume Groups (VG)
```bash
# Create VG
vgcreate data /dev/sda1 /dev/sdb1

# Extend
vgextend data /dev/sdc1
```

#### Logical Volumes (LV)
```bash
# Create LV
lvcreate -L 100G -n home data

# Resize
lvresize -L +50G /dev/data/home
resize2fs /dev/data/home
```

## Encryption

### LUKS
```bash
# Create encrypted partition
cryptsetup luksFormat /dev/sda1

# Open
cryptsetup open /dev/sda1 crypt

# Auto-unlock (/etc/crypttab)
crypt  UUID=xxx  none  luks
```

### VeraCrypt
```bash
# Create container
veracrypt -c

# Mount
veracrypt /path/to/container /mnt/veracrypt1
```

## Monitoring and Maintenance

### Disk Monitoring

#### SMART
```bash
# Installation
pacman -S smartmontools

# Health check
smartctl -H /dev/sda

# Detailed info
smartctl -a /dev/sda

# Enable monitoring
smartd -s on
```

#### I/O Monitoring
```bash
# I/O monitoring
iotop
iostat -x 1

# Latency
ioping -c 10 /dev/sda
```

### Maintenance

#### Defragmentation
```bash
# ext4
e4defrag /

# btrfs
btrfs filesystem defragment -r /
```

#### File System Checks
```bash
# ext4
fsck.ext4 -f /dev/sda1

# btrfs
btrfs check /dev/sda1
```

## Performance and Optimization

### SSD Optimization
```bash
# TRIM
systemctl enable fstrim.timer

# I/O scheduler
echo "mq-deadline" > /sys/block/sda/queue/scheduler

# Mount options
noatime,discard=async
```

### Buffer Cache
```bash
# /etc/sysctl.d/99-sysctl.conf
vm.dirty_ratio = 10
vm.dirty_background_ratio = 5
vm.swappiness = 10
```

## Backup

### Backup Tools

#### rsync
```bash
# Basic backup
rsync -av --delete /source/ /backup/

# Incremental backup
rsync -av --link-dest=/backup/previous /source/ /backup/current
```

#### timeshift
```bash
# Create snapshot
timeshift --create

# Restore
timeshift --restore
```

## Best Practices

1. **Planning**
   - Consider partition scheme
   - Choose appropriate file systems
   - Consider RAID/LVM

2. **Security**
   - Regular backups
   - SMART monitoring
   - Encryption of sensitive data

3. **Maintenance**
   - Regular checks
   - Firmware updates
   - Monitoring free space

## References
- [Arch Wiki - Partitioning](https://wiki.archlinux.org/title/Partitioning)
- [Arch Wiki - File systems](https://wiki.archlinux.org/title/File_systems)
- [Arch Wiki - LVM](https://wiki.archlinux.org/title/LVM) 