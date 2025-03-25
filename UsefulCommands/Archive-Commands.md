# Working with Archives - Useful Commands

## Tar
### Basic Operations
```bash
# Create archive
tar -czf archive.tar.gz files/

# Extract archive
tar -xzf archive.tar.gz

# List contents
tar -tvf archive.tar.gz

# Add to archive
tar -rf archive.tar file
```

### Advanced Options
```bash
# Compression with different algorithms
tar -cjf archive.tar.bz2 files/  # bzip2
tar -cJf archive.tar.xz files/   # xz
tar --zstd -cf archive.tar.zst files/  # zstd

# Exclude files
tar -czf archive.tar.gz --exclude='*.tmp' files/

# Preserve permissions
tar -czpf archive.tar.gz files/
```

## Zip/Unzip
### Basic Operations
```bash
# Create zip archive
zip -r archive.zip files/

# Extract zip archive
unzip archive.zip

# List contents
unzip -l archive.zip

# Test archive
unzip -t archive.zip
```

### Advanced Options
```bash
# Password protection
zip -e archive.zip files/

# Update existing archive
zip -u archive.zip new_files/

# Split into parts
zip -s 10m archive.zip files/
```

## 7-Zip
### Basic Operations
```bash
# Create archive
7z a archive.7z files/

# Extract archive
7z x archive.7z

# List contents
7z l archive.7z

# Test integrity
7z t archive.7z
```

### Advanced Options
```bash
# Set compression level
7z a -mx=9 archive.7z files/

# Encryption
7z a -p archive.7z files/

# Split into parts
7z a -v100m archive.7z files/
```

## Rar
### Basic Operations
```bash
# Create archive
rar a archive.rar files/

# Extract archive
unrar x archive.rar

# List contents
unrar l archive.rar

# Test archive
unrar t archive.rar
```

### Advanced Options
```bash
# Create SFX archive
rar a -sfx archive.exe files/

# Repair damaged archive
rar r archive.rar

# Encryption
rar a -p archive.rar files/
```

## File Compression
### Gzip
```bash
# Compress file
gzip file

# Decompress
gunzip file.gz

# Keep original
gzip -k file

# Test integrity
gzip -t file.gz
```

### Bzip2
```bash
# Compress file
bzip2 file

# Decompress
bunzip2 file.bz2

# Keep original
bzip2 -k file

# Maximum compression
bzip2 -9 file
```

## Archive Management
### Format Conversion
```bash
# Convert tar.gz to zip
tar -xzf archive.tar.gz && zip -r archive.zip files/

# Convert zip to 7z
7z a archive.7z archive.zip

# Extract and recompress
tar -xzf old.tar.gz && tar -cjf new.tar.bz2 files/
```

### Maintenance
```bash
# Integrity check
tar -tvf archive.tar.gz
unzip -t archive.zip
7z t archive.7z

# Repair damaged archives
zip -F archive.zip --out fixed.zip
rar r archive.rar
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias targz='tar -czf'
alias untargz='tar -xzf'
alias zipdir='zip -r'
alias 7zc='7z a'
alias 7zx='7z x'
```

## Automation
```bash
# Automatic log compression
#!/bin/bash
find /var/log -name "*.log" -mtime +7 -exec gzip {} \;

# Regular archiving
#!/bin/bash
tar -czf backup-$(date +%Y%m%d).tar.gz /data/
find . -name "backup-*.tar.gz" -mtime +30 -delete
```