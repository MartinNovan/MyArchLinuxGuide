# Desktop Environments and Display Managers

## Introduction
This document provides a detailed description of various desktop environments (DE) and display managers (DM) available in Arch Linux, including their advantages, disadvantages, configuration, and recommended usage.

## Desktop Environments (DE - Desktop Environments)

### KDE Plasma
**Advantages:**
- Highly customizable (widgets, panels, effects)
- Modern look with impressive compositing
- Wide application support (KDE applications)
- Integrated settings system

**Disadvantages:**
- Higher system resource requirements (RAM, CPU)
- More complex configuration (many options)
- Sometimes unstable (especially with custom effects)

**Installation:**
```bash
sudo pacman -S plasma-meta kde-applications-meta
```

**Configuration:**
- System Settings → Custom settings
- KWin compositor → Effects
- Plasma Widgets → Add widgets

### GNOME
**Advantages:**
- Simple and intuitive (minimalist)
- Good Wayland support (default since GNOME 40)
- Integrated applications (GNOME Software, Files)
- Touch-friendly interface

**Disadvantages:**
- Less customizable (limited extensions)
- Higher system resource requirements
- GNOME Shell can be unintuitive for some

**Installation:**
```bash
sudo pacman -S gnome gnome-extra
```

**Configuration:**
- GNOME Tweaks → Extensions
- GNOME Software → Applications
- dconf Editor → Advanced settings

### XFCE
**Advantages:**
- Lightweight and fast (low resource usage)
- Highly customizable (panels, menus)
- Stable and reliable
- Ideal for older hardware

**Disadvantages:**
- Older look (less modern)
- Fewer modern features (limited compositing)
- Limited Wayland support

**Installation:**
```bash
sudo pacman -S xfce4 xfce4-goodies
```

**Configuration:**
- XFCE Settings Manager → All settings
- Panel → Add/remove items
- Window Manager → Styles and effects

### MATE
**Advantages:**
- Traditional look (inspired by GNOME 2)
- Low system resource requirements
- Good stability and reliability
- Easy transition from GNOME 2

**Disadvantages:**
- Fewer modern features (limited effects)
- Limited Wayland support
- Smaller community

**Installation:**
```bash
sudo pacman -S mate mate-extra
```

**Configuration:**
- MATE Control Center → All settings
- Panel → Customization
- Window Manager → Styles and effects

### Hyprland
**Advantages:**
- Modern Wayland compositor
- Highly customizable (animations, effects)
- Good HiDPI support
- Active development

**Disadvantages:**
- Less mature technology
- Limited application support
- Requires manual configuration

**Installation:**
```bash
yay -S hyprland
```

**Configuration:**
```bash
mkdir -p ~/.config/hypr
nano ~/.config/hypr/hyprland.conf
```

### Sway
**Advantages:**
- Wayland alternative to i3
- Low system resource requirements
- Good HiDPI support
- Easy configuration

**Disadvantages:**
- Limited application support
- Requires manual configuration
- Fewer effects than Hyprland

**Installation:**
```bash
sudo pacman -S sway
```

**Configuration:**
```bash
mkdir -p ~/.config/sway
cp /etc/sway/config ~/.config/sway/
nano ~/.config/sway/config
```

### i3
**Advantages:**
- Lightweight and fast
- Highly customizable
- Wide application support
- Large community

**Disadvantages:**
- X11 only (no Wayland support)
- Requires manual configuration
- Fewer effects than modern WM

**Installation:**
```bash
sudo pacman -S i3
```

**Configuration:**
```bash
mkdir -p ~/.config/i3
cp /etc/i3/config ~/.config/i3/
nano ~/.config/i3/config
```

### Budgie
**Advantages:**
- Modern look
- Integrated applications
- Good stability
- Easy to use

**Disadvantages:**
- Higher system resource requirements
- Smaller community
- Limited Wayland support

**Installation:**
```bash
sudo pacman -S budgie-desktop
```

**Configuration:**
- Budgie Settings → All settings
- Raven → Panel customization
- Applets → Add/remove applets

### Cinnamon
**Advantages:**
- Traditional look (inspired by GNOME 3)
- Easy to use
- Good stability
- Integrated applications

**Disadvantages:**
- Higher system resource requirements
- Limited Wayland support
- Smaller community

**Installation:**
```bash
sudo pacman -S cinnamon
```

**Configuration:**
- Cinnamon Settings → All settings
- Panel → Customization
- Applets → Add/remove applets

## Display Managers (DM - Display Managers)

### GDM (GNOME Display Manager)
**Advantages:**
- Integration with GNOME (default for GNOME)
- Wayland support (default since GNOME 40)
- Modern look (animations, backgrounds)
- Automatic monitor detection

**Disadvantages:**
- Higher system resource requirements
- Limited customization
- Issues with some themes

**Installation:**
```bash
sudo pacman -S gdm
```

**Configuration:**
```bash
sudo nano /etc/gdm/custom.conf
```
```ini
[daemon]
WaylandEnable=true
AutomaticLoginEnable=true
AutomaticLogin=username
```

### SDDM (Simple Desktop Display Manager)
**Advantages:**
- Integration with KDE (default for KDE)
- Customizable (themes, backgrounds)
- Low system resource requirements
- Wayland support

**Disadvantages:**
- Fewer modern features
- Limited Wayland support
- Issues with some themes

**Installation:**
```bash
sudo pacman -S sddm
```

**Configuration:**
```bash
sudo nano /etc/sddm.conf
```
```ini
[Theme]
Current=breeze
CursorTheme=breeze_cursors
```

### LightDM
**Advantages:**
- Lightweight and fast (low resource usage)
- Highly customizable (various greeters)
- Support for various DE
- Easy configuration

**Disadvantages:**
- Basic look
- Limited Wayland support
- Issues with some themes

**Installation:**
```bash
sudo pacman -S lightdm lightdm-gtk-greeter
```

**Configuration:**
```bash
sudo nano /etc/lightdm/lightdm.conf
```
```ini
[Seat:*]
greeter-session=lightdm-gtk-greeter
user-session=xfce
```

## Display Servers a Compository (DS - Display Servers)

Tato sekce popisuje různé technologie pro zobrazování a správu oken v Linuxu.

### X.Org (X11)
**Advantages:**
- Mature technology (decades of development)
- Wide application support (including older ones)
- Good stability (proven in practice)
- Support for multiple monitors (including various DPI)

**Disadvantages:**
- Complex architecture (older design)
- Security issues (X11 forwarding)
- Limited HiDPI support (poor scaling)
- Issues with modern features (sync, tearing)

**Technology:**
- **Display Server**: X.Org Server
- **Compositor**: Standalone (Compiz, Picom) or integrated (KWin, Mutter)

### Wayland
**Advantages:**
- Modern architecture (simpler design)
- Better security (isolated clients)
- Better HiDPI support (automatic scaling)
- Better performance (less overhead)

**Disadvantages:**
- Less mature technology (still in development)
- Limited application support (mainly older ones)
- Issues with some features (screenshots)
- Limited support for multiple monitors (various DPI)

**Technology:**
- **Display Server + Compositor**: Wayland compositor (Weston, Sway, Hyprland)
- **Integrated**: Compositor is part of Wayland server

### XWayland
**Advantages:**
- Compatibility with X11 applications
- Integration with Wayland
- Automatic use for older applications

**Disadvantages:**
- Additional overhead (X11 emulation)
- Limited support for some features
- Performance issues

**Technology:**
- **X11 Emulation**: XWayland runs as Wayland client
- **Automatic Use**: For applications that don't support Wayland

## Recommended Practices

1. **Choosing DE**
   - Consider your needs and hardware
   - Test various DE (live USB)
   - Use what suits you

2. **Configuration**
   - Regularly back up configuration files
   - Experiment with different settings
   - Follow community news

3. **Updates**
   - Regularly update DE and DM
   - Follow Wayland support changes
   - Test new features

## Useful Links
- [Arch Wiki - Desktop environment](https://wiki.archlinux.org/title/Desktop_environment)
- [Arch Wiki - Display manager](https://wiki.archlinux.org/title/Display_manager)
- [Arch Wiki - Wayland](https://wiki.archlinux.org/title/Wayland)
- [KDE Plasma](https://kde.org/plasma-desktop/)
- [GNOME](https://www.gnome.org/)
- [XFCE](https://www.xfce.org/)
- [MATE](https://mate-desktop.org/)
- [Hyprland](https://hyprland.org/)
- [Sway](https://swaywm.org/)
- [i3](https://i3wm.org/)
- [Budgie](https://buddiesofbudgie.org/)
- [Cinnamon](https://projects.linuxmint.com/cinnamon/) 