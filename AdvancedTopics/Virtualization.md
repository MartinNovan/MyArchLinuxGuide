# Virtualization in Arch Linux

## Introduction
Virtualization allows running multiple operating systems on a single physical machine. This document describes the setup and use of various virtualization technologies in Arch Linux.

## Technology Comparison

### KVM/QEMU
**Advantages:**
- Full virtualization (Type 1 hypervisor)
- High performance with hardware acceleration
- Linux integration
- Virtio support for optimization

**Disadvantages:**
- More complex configuration
- Requires VT-x/AMD-V support

**Use Cases:**
- Production servers
- Development and testing
- Cloud environments

### VirtualBox
**Advantages:**
- Easy to use
- Cross-platform
- Wide support for guest OSes
- Snapshots and cloning

**Disadvantages:**
- Lower performance than KVM
- Limited scalability
- Dependency on Oracle

**Use Cases:**
- Desktop environment
- Testing different OSes
- Educational purposes

### LXC/LXD
**Advantages:**
- Lightweight containers (shared kernel)
- Fast startup
- Low overhead
- Easy management

**Disadvantages:**
- Linux containers only
- Less isolation than full virtualization
- Shared kernel can be a risk

**Use Cases:**
- Microservices
- CI/CD pipelines
- Development environment

### Docker
**Advantages:**
- Standardized packages (images)
- Easy application distribution
- Large community
- Extensive image library

**Disadvantages:**
- Primarily for applications, not full OSes
- More complex network configuration
- Security risks

**Use Cases:**
- Application containerization
- Development and deployment
- Cloud applications

## How They Work

### KVM/QEMU
- Type 1 hypervisor
- Direct hardware access
- Virtual machines with their own kernel
- Hardware acceleration

### VirtualBox
- Type 2 hypervisor
- Hardware emulation
- Guest OS runs on top of host OS
- Software emulation

### LXC/LXD
- Container virtualization
- Shared host kernel
- Isolated user environment
- Cgroups and namespaces

### Docker
- Application containers
- Shared host kernel
- Isolated environment for applications
- Layered file system

## KVM/QEMU

### Installation
```bash
sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat
```

### Configuration
1. Enable and start services:
```bash
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
```
2. Add user to group:
```bash
sudo usermod -aG libvirt $USER
```

### Create a Virtual Machine
1. Start Virt-Manager:
```bash
virt-manager
```
2. Follow the wizard:
   - Select installation type
   - Add ISO image
   - Set parameters (RAM, CPU, disk)

### Command Line Control
```bash
# List VMs
virsh list --all

# Start VM
virsh start vm_name

# Shutdown VM
virsh shutdown vm_name
```

## VirtualBox

### Installation
```bash
sudo pacman -S virtualbox virtualbox-host-dkms
```

### Configuration
1. Load kernel modules:
```bash
sudo modprobe vboxdrv vboxnetadp vboxnetflt
```
2. Add user to group:
```bash
sudo usermod -aG vboxusers $USER
```

### Create a Virtual Machine
1. Start VirtualBox
2. Click "New" and follow the wizard

## LXC/LXD

### Installation
```bash
sudo pacman -S lxc lxd
```

### Configuration
1. Initialize LXD:
```bash
sudo lxd init
```
2. Add user to group:
```bash
sudo usermod -aG lxd $USER
```

### Create a Container
```bash
lxc launch ubuntu:20.04 mycontainer
```

### Manage Containers
```bash
# List containers
lxc list

# Start container
lxc start mycontainer

# Attach to container
lxc exec mycontainer -- /bin/bash
```

## Docker

### Installation
```bash
sudo pacman -S docker docker-compose
```

### Configuration
1. Enable and start service:
```bash
sudo systemctl enable docker.service
sudo systemctl start docker.service
```
2. Add user to group:
```bash
sudo usermod -aG docker $USER
```

### Basic Commands
```bash
# Pull image
docker pull ubuntu:20.04

# Run container
docker run -it ubuntu:20.04 /bin/bash

# List containers
docker ps -a
```

## Optimization

### Virtio
- Use Virtio drivers for better performance
- Virtio disk, network, and other peripherals

### CPU Pinning
- Pin virtual CPUs to physical cores
- Improves performance and reduces latency

### I/O Caching
- Use writeback caching for better disk performance
- Be cautious of data loss risk

## Troubleshooting

### KVM
```bash
# Check virtualization support
egrep -c '(vmx|svm)' /proc/cpuinfo

# Check loaded modules
lsmod | grep kvm
```

### VirtualBox
```bash
# Check service status
systemctl status vboxdrv

# Rebuild kernel modules
sudo vboxreload
```

### LXC/LXD
```bash
# Check configuration
lxc config show

# Check logs
journalctl -u lxd
```

## Useful References
- [Arch Wiki - KVM](https://wiki.archlinux.org/title/KVM)
- [Arch Wiki - VirtualBox](https://wiki.archlinux.org/title/VirtualBox)
- [Arch Wiki - LXC](https://wiki.archlinux.org/title/LXC)
- [Arch Wiki - Docker](https://wiki.archlinux.org/title/Docker) 