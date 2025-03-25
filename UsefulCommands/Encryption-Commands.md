# Encryption - Useful Commands

## GPG (GnuPG)
### Key Management
```bash
# Generate new key
gpg --full-generate-key

# List keys
gpg --list-keys
gpg --list-secret-keys

# Export keys
gpg --export -a "User Name" > public.key
gpg --export-secret-key -a "User Name" > private.key

# Import keys
gpg --import public.key
```

### File Encryption
```bash
# Encrypt for recipient
gpg -e -r "recipient" file

# Encrypt with password
gpg -c file

# Decrypt
gpg -d file.gpg

# Sign file
gpg --sign file
```

## LUKS (Disk Encryption)
### Basic Operations
```bash
# Create encrypted partition
cryptsetup luksFormat /dev/sdX

# Open partition
cryptsetup open /dev/sdX name

# Close partition
cryptsetup close name

# Formatting
mkfs.ext4 /dev/mapper/name
```

### LUKS Management
```bash
# Encryption information
cryptsetup luksDump /dev/sdX

# Add backup key
cryptsetup luksAddKey /dev/sdX

# Remove key
cryptsetup luksRemoveKey /dev/sdX

# Change password
cryptsetup luksChangeKey /dev/sdX
```

## SSL/TLS
### Certificates
```bash
# Generate self-signed certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout private.key -out certificate.crt

# Generate CSR
openssl req -new -newkey rsa:2048 -nodes \
    -keyout private.key -out request.csr

# Check certificate
openssl x509 -in certificate.crt -text
```

### SSL Testing
```bash
# Test SSL connection
openssl s_client -connect host:443

# Test SSL configuration
nmap --script ssl-enum-ciphers -p 443 host

# Check certificate validity
echo | openssl s_client -servername host -connect host:443 2>/dev/null | openssl x509 -noout -dates
```

## Other Tools
### VeraCrypt
```bash
# Create container
veracrypt -c

# Mount container
veracrypt file /mnt/point

# Unmount
veracrypt -d
```

### ccrypt
```bash
# Encrypt file
ccrypt file.txt

# Decrypt
ccrypt -d file.txt.cpt

# Change password
ccrypt -x file.txt.cpt
```

## Hashing
### Generate Hashes
```bash
# MD5
md5sum file

# SHA-256
sha256sum file

# SHA-512
sha512sum file

# Verify hashes
sha256sum -c hash.txt
```

## Secure Deletion
### Secure deletion
```bash
# Overwrite file
shred -u file

# Multiple overwrites
shred -n 7 -u file

# Overwrite entire partition
dd if=/dev/urandom of=/dev/sdX bs=4M status=progress
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias encrypt='gpg -c'
alias decrypt='gpg -d'
alias secure-delete='shred -u'
alias checksum='sha256sum'
```

## Automation
```bash
# Automatic encryption
#!/bin/bash
for file in *.txt; do
    gpg -c "$file"
    rm "$file"
done

# Automatic encrypted backup
#!/bin/bash
tar czf - /important/data | gpg -c > backup.tar.gz.gpg
```