# Biometric Authentication in Arch Linux

## Introduction
This document describes the setup and configuration of biometric authentication in Arch Linux, including fingerprint and facial recognition.

## Fingerprint Authentication

### Requirements
- Supported fingerprint reader
- `fprintd` package

### Installation
```bash
sudo pacman -S fprintd
```

### Fingerprint Enrollment
1. Enroll a fingerprint:
```bash
fprintd-enroll
```
2. Verify functionality:
```bash
fprintd-verify
```

### PAM Integration
1. Edit PAM configuration:
```bash
sudo nano /etc/pam.d/system-auth
```
2. Add the following line before `auth required pam_unix.so`:
```bash
auth sufficient pam_fprintd.so
```

### Troubleshooting
```bash
# Check service status
systemctl status fprintd

# Check device support
lsusb | grep -i fingerprint
```

## Facial Recognition (Howdy)

### Requirements
- IR-supported webcam
- `howdy` package

### Installation
```bash
yay -S howdy
```

### Configuration
1. Edit the configuration file:
```bash
sudo howdy config
```
2. Important settings:
```ini
[core]
detection_notice = false
```

### Add Face
```bash
sudo howdy add
```

### Testing
```bash
sudo howdy test
```

### PAM Integration
1. Edit PAM configuration:
```bash
sudo nano /etc/pam.d/system-auth
```
2. Add the following line before `auth required pam_unix.so`:
```bash
auth sufficient pam_python.so /usr/lib/security/howdy/pam.py
```

### Troubleshooting
```bash
# Check logs
journalctl -u howdy

# Check camera support
ls /dev/video*
```

## Security Recommendations

1. **PAM Configuration Backup**
   - Always back up PAM files before making changes
   - Keep a working copy in case of errors

2. **Multi-Factor Authentication**
   - Combine biometric methods with passwords
   - Use biometrics as a supplementary method

3. **Monitoring**
   - Regularly check logs
   - Test functionality after updates

## References
- [Arch Wiki - Fprint](https://wiki.archlinux.org/title/Fprint)
- [Howdy GitHub](https://github.com/boltgolt/howdy)
- [PAM Documentation](https://linux.die.net/man/8/pam) 