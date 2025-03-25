# Performance Tuning in Arch Linux

## Introduction
This document describes various techniques and tools for optimizing the performance of Arch Linux. It focuses on optimizing CPU, memory, I/O, and other system resources.

## Basic Optimization

### System Status Check
```bash
# CPU Load
htop

# Memory Usage
free -h

# I/O Operations
iotop

# Network Activity
nload
```

### System Update
```bash
sudo pacman -Syu
```

### Choosing the Right Kernel
```bash
# Check Current Kernel
uname -r

# Try Alternative Kernel
sudo pacman -S linux-zen
```

## CPU Optimization

### CPU Frequency
```bash
# Install cpupower
sudo pacman -S cpupower

# Set Performance Mode
sudo cpupower frequency-set -g performance
```

### Process Scheduling
```bash
# Check Current Scheduler
cat /sys/block/sda/queue/scheduler

# Set CFQ Scheduler
echo cfq | sudo tee /sys/block/sda/queue/scheduler
```

## Memory Optimization

### Swappiness
```bash
# Check Current Value
cat /proc/sys/vm/swappiness

# Set Swappiness
echo 10 | sudo tee /proc/sys/vm/swappiness
```

### Transparent Huge Pages
```bash
# Enable THP
echo always | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
```

## I/O Optimization

### Filesystem
```bash
# Check Filesystem
df -T

# Optimize ext4
sudo tune2fs -o journal_data_writeback /dev/sda1
```

### I/O Scheduler
```bash
# Set Deadline Scheduler
echo deadline | sudo tee /sys/block/sda/queue/scheduler
```

## Network Optimization

### TCP Tuning
```bash
# Increase Buffers
echo 'net.core.rmem_max=16777216' | sudo tee -a /etc/sysctl.conf
echo 'net.core.wmem_max=16777216' | sudo tee -a /etc/sysctl.conf
```

### Offloading
```bash
# Enable TCP Offload
sudo ethtool -K eth0 tx on rx on tso on gso on
```

## Graphical Environment

### Compositing
```bash
# Disable Compositing in KDE
kwin_x11 --replace &
```

### GPU Acceleration
```bash
# Check GPU
glxinfo | grep "OpenGL renderer"

# Install Drivers
sudo pacman -S nvidia
```

## Useful Tools

### Benchmarking
```bash
# CPU
sudo pacman -S sysbench

# Disk
sudo pacman -S fio

# Network
sudo pacman -S iperf
```

### Monitoring
```bash
# Overview
sudo pacman -S glances

# I/O
sudo pacman -S iotop

# Network
sudo pacman -S nethogs
```

## Best Practices

1. **Incremental Optimization**
   - Change one thing at a time
   - Measure the impact of each change
   - Keep records of changes

2. **Monitoring**
   - Regularly check system performance
   - Set alerts for critical values
   - Analyze long-term trends

3. **Backups**
   - Always backup before making changes
   - Maintain a working configuration
   - Have a plan to revert to a previous state

## Useful References
- [Arch Wiki - Improving performance](https://wiki.archlinux.org/title/Improving_performance)
- [Linux Performance](https://www.brendangregg.com/linuxperf.html)
- [Phoronix Test Suite](https://www.phoronix-test-suite.com/) 