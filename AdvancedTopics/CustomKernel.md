# Custom Kernel in Arch Linux

## Introduction
Compiling a custom kernel allows you to optimize the system for specific hardware, add or remove features, and improve performance. This guide walks you through the process of compiling and installing a custom kernel.

## Requirements
- Basic command line knowledge
- Sufficient disk space (min. 10 GB)
- Installed development tools

## Install Required Packages
```bash
sudo pacman -S base-devel bc kmod libelf pahole cpio perl tar xz git
```

## Download Kernel Source Code
1. Download the source code:
```bash
git clone https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
cd linux
```
2. Select the kernel version:
```bash
git tag -l | grep v5.
git checkout v5.15
```

## Kernel Configuration
1. Copy the current configuration:
```bash
cp /proc/config.gz .
gunzip config.gz
mv config .config
```
2. Run the configuration tool:
```bash
make menuconfig
```
3. Make necessary changes:
   - Optimize for specific CPU
   - Add/remove drivers
   - Enable/disable experimental features

## Compile the Kernel
1. Start the compilation:
```bash
make -j$(nproc)
```
2. Compile modules:
```bash
make modules
```
3. Install modules:
```bash
sudo make modules_install
```

## Install the Kernel
1. Install the kernel:
```bash
sudo make install
```
2. Update GRUB:
```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

## Troubleshooting
### Kernel Won't Boot
1. Boot from the previous kernel
2. Check the configuration:
```bash
dmesg | grep -i error
```

### Missing Drivers
1. Check device support:
```bash
lspci -k
```
2. Add necessary drivers to the configuration

## Optimization
### CPU
```bash
Processor type and features  --->
  Processor family (Core 2/newer Xeon)  --->
    (X) Core 2/newer Xeon
```

### I/O Scheduler
```bash
Device Drivers  --->
  Multi-device support (RAID and LVM)  --->
    <*> RAID support
    <*> Device mapper support
```

### Security
```bash
Security options  --->
  <*> Enable different security models
  <*> Integrity subsystem
```

## Useful References
- [Arch Wiki - Kernel](https://wiki.archlinux.org/title/Kernel)
- [Kernel Newbies](https://kernelnewbies.org/)
- [Linux Kernel Documentation](https://www.kernel.org/doc/html/latest/) 