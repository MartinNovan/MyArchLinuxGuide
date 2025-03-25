# Detailed Analysis of PAM Configuration Files

## ags

```
auth include login
```
Simple configuration that only includes settings from [login](#login). All authentication checks are delegated to the login configuration.

## groupmems
```groupmems
#%PAM-1.0
auth     sufficient  pam_rootok.so
account  required    pam_permit.so
password include     system-auth
```
- `pam_rootok.so`: Allows direct access for root users without further authentication
- `pam_permit.so`: Always allows account access after successful authentication
- Uses passwords from [system-auth](#system-auth)

## chfn
```chfn
#%PAM-1.0
auth        sufficient  pam_rootok.so
auth        required    pam_unix.so
account     required    pam_unix.so
session     required    pam_unix.so
password    required    pam_permit.so
```
- `pam_rootok.so`: Root has direct access
- `pam_unix.so`: Standard Unix authentication for other users
- `pam_permit.so`: Allows password change

## chpasswd
```chpasswd
#%PAM-1.0
auth     sufficient  pam_rootok.so
account  required    pam_permit.so
password include     system-auth
```
Similar to groupmems, used for bulk password changes.

## chsh
```chsh
#%PAM-1.0
auth        sufficient  pam_rootok.so
auth        required    pam_unix.so
account     required    pam_unix.so
session     required    pam_unix.so
password    required    pam_permit.so
```
Identical configuration to chfn, used for changing user shell.

## kde
```kde
#%PAM-1.0
auth       include     system-local-login
account    include     system-local-login
password   include     system-local-login
session    include     system-local-login
```
Completely delegates all checks to [system-local-login](#system-local-login).

## kde-fingerprint
```kde-fingerprint
#%PAM-1.0
auth       required    pam_shells.so
auth       requisite   pam_nologin.so
auth       requisite   pam_faillock.so preauth
-auth      required    pam_fprintd.so
auth       optional    pam_permit.so
auth       required    pam_env.so

account    include     system-local-login
password   required    pam_deny.so
session    include     system-local-login
```
- Checks allowed shells
- Checks /etc/nologin
- Implements attack protection (faillock)
- Requires fingerprint verification
- Sets environment
- Prohibits password change (pam_deny.so)

## kde-smartcard
```kde-smartcard
#%PAM-1.0
auth       requisite   pam_nologin.so
auth       requisite   pam_faillock.so preauth
-auth      required    pam_pkcs11.so wait_for_card card_only
auth       required    pam_shells.so
auth       optional    pam_permit.so
auth       required    pam_env.so
```
- `pam_nologin.so`: Checks login prohibition
- `pam_faillock.so`: Protection against brute force attacks
- `pam_pkcs11.so`: Requires smart card with parameters:
  - `wait_for_card`: Waits for card insertion
  - `card_only`: Allows only card authentication
- Checks allowed shells and sets environment

## login
```
#%PAM-1.0
auth       requisite    pam_nologin.so
auth       include      system-local-login
account    include      system-local-login
session    include      system-local-login
password   include      system-local-login
```
- First checks /etc/nologin
- Delegates all other checks to [system-local-login](#system-local-login)

## newusers
```
#%PAM-1.0
auth       sufficient  pam_rootok.so
account    required    pam_permit.so
password   include     system-auth
```
- Allows root access without verification
- Always allows account access
- Uses standard password management from [system-auth](#system-auth)

## other
```
#%PAM-1.0
auth      required   pam_deny.so
auth      required   pam_warn.so
account   required   pam_deny.so
account   required   pam_warn.so
password  required   pam_deny.so
password  required   pam_warn.so
session   required   pam_deny.so
session   required   pam_warn.so
```
Security configuration for unspecified services:
- Denies all types of access (`pam_deny.so`)
- Logs all access attempts (`pam_warn.so`)

## passwd
```
#%PAM-1.0
auth     include     system-auth
account  include     system-auth
password include     system-auth
```
Completely delegates authentication to [system-auth](#system-auth)

## remote
```
#%PAM-1.0
auth       required     pam_securetty.so
auth       requisite    pam_nologin.so
auth       include      system-remote-login
account    include      system-remote-login
session    include      system-remote-login
password   include      system-remote-login
```
- Checks secure TTY (`pam_securetty.so`)
- Checks /etc/nologin
- Delegates other checks to [system-remote-login](#system-remote-login)

## runuser and runuser-l
```
#%PAM-1.0
auth    sufficient      pam_rootok.so
session include         system-login
```
- Allows access only for root user
- Uses standard session settings

## sddm
```
#%PAM-1.0
auth        include     system-login
-auth       optional    pam_gnome_keyring.so
-auth       optional    pam_kwallet5.so

account     include     system-login
password    include     system-login

session     optional    pam_keyinit.so force revoke
session     include     system-login
-session    optional    pam_gnome_keyring.so auto_start
-session    optional    pam_kwallet5.so auto_start
```
- Uses basic login from [system-login](#system-login)
- Optional integration with GNOME Keyring
- Optional integration with KWallet5
- Cryptographic key management (`pam_keyinit.so`)

## sddm-autologin
```
#%PAM-1.0
auth        required    pam_env.so
auth        required    pam_faillock.so preauth
auth        required    pam_shells.so
auth        required    pam_nologin.so
auth        required    pam_permit.so
-auth       optional    pam_gnome_keyring.so
-auth       optional    pam_kwallet5.so
```
- Sets environment
- Implements attack protection
- Checks allowed shells
- Checks /etc/nologin
- Optional integration with GNOME Keyring and KWallet

## sddm-greeter
```
#%PAM-1.0
auth        required pam_env.so
auth        required pam_permit.so
account     required pam_permit.so
password    required pam_deny.so
session     required pam_unix.so
session     optional pam_systemd.so
```
- Loads environment
- Allows greeter to run without authentication
- Prohibits password change
- Basic Unix session
- Integration with systemd

## sshd
```
#%PAM-1.0
auth      include   system-remote-login
account   include   system-remote-login
password  include   system-remote-login
session   include   system-remote-login
```
Completely delegates checks to [system-remote-login](#system-remote-login)

## su and su-l
```
#%PAM-1.0
auth            sufficient      pam_rootok.so
# Uncomment the following line to implicitly trust users in the "wheel" group.
#auth           sufficient      pam_wheel.so trust use_uid
# Uncomment the following line to require a user to be in the "wheel" group.
#auth           required        pam_wheel.so use_uid
auth            required        pam_unix.so
account         required        pam_unix.so
session         required        pam_unix.so
password        include         system-auth
```
- Root has direct access
- Optional wheel group check
- Standard Unix authentication
- Uses passwords from [system-auth](#system-auth)

## sudo
```
#%PAM-1.0
auth    [success=1 new_authtok_reqd=1 default=ignore]  pam_unix.so try_first_pass likeauth nullok
auth    sufficient  pam_fprintd.so
auth    include     system-auth
account include     system-auth
session include     system-auth
```
- First attempts Unix authentication
- Allows biometric authentication as alternative
- Uses [system-auth](#system-auth) for further checks

## system-auth
```
#%PAM-1.0
auth       [success=2 default=ignore]   pam_fprintd.so
auth       sufficient                   pam_unix.so try_first_pass likeauth nullok
auth       required                     pam_faillock.so preauth
auth       [success=1 default=bad]      pam_unix.so try_first_pass nullok
auth       [default=die]                pam_faillock.so authfail
auth       optional                     pam_permit.so
auth       required                     pam_env.so
auth       required                     pam_faillock.so authsucc
```
Complex authentication configuration:
- Biometric authentication
- Unix authentication with multiple attempts
- Protection against brute force attacks
- Environment setup
- Account and session management

## system-local-login
```
#%PAM-1.0
auth      include   system-login
account   include   system-login
password  include   system-login
session   include   system-login
```
Delegates all checks to [system-login](#system-login)

## system-login
```
#%PAM-1.0
auth       required   pam_shells.so
auth       requisite  pam_nologin.so
auth       include    system-auth

account    required   pam_access.so
account    required   pam_nologin.so
account    include    system-auth

password   include    system-auth

session    optional   pam_loginuid.so
session    optional   pam_keyinit.so force revoke
session    include    system-auth
session    optional   pam_motd.so
session    optional   pam_mail.so dir=/var/spool/mail standard quiet
session    optional   pam_umask.so
-session   optional   pam_systemd.so
session    required   pam_env.so
```
- Shell and /etc/nologin check
- Access control using /etc/security/access.conf
- Cryptographic key management
- MOTD display
- Mail check
- Umask setup
- Integration with systemd
- Environment setup

## system-remote-login
```
#%PAM-1.0
auth      include   system-login
account   include   system-login
password  include   system-login
session   include   system-login
```
Delegates checks to [system-login](#system-login)

## system-services
```
#%PAM-1.0
auth      sufficient  pam_permit.so
account   include     system-auth
session   optional    pam_loginuid.so
session   required    pam_limits.so
session   required    pam_unix.so
session   optional    pam_permit.so
session   required    pam_env.so
```
- Minimal authentication for services
- Standard account control
- Loginuid setup
- System resource limits application
- Basic Unix session
- Environment setup

## systemd-user
```
account  include system-login
session  required pam_loginuid.so
session  include system-login
```
- Uses account checks from [system-login](#system-login)
- Sets loginuid
- Uses session settings from [system-login](#system-login)

## vlock
```
#%PAM-1.0
auth required pam_unix.so
account required pam_unix.so
password required pam_unix.so
session required pam_unix.so
```
Simple configuration for virtual console locking:
- Uses standard Unix authentication for all types of checks

