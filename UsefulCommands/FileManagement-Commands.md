# File Management - Useful Commands

## Basic File Operations
### Creating and Deleting
```bash
# Create file
touch file.txt

# Create directory
mkdir new_directory

# Create multiple nested directories
mkdir -p path/to/new/directory

# Delete files
rm file.txt

# Delete directories
rm -r directory
rm -rf directory  # Force delete
```

### Copying and Moving
```bash
# Copy file
cp source.txt target.txt

# Copy directory
cp -r source_directory target_directory

# Move/rename
mv old_name.txt new_name.txt

# Move with confirmation
mv -i file.txt new/directory/
```

## File Searching
### Find
```bash
# Search by name
find /path -name "*.txt"

# Search by size
find /home -size +100M  # Larger than 100MB
find /home -size -1M    # Smaller than 1MB

# Search by modification date
find /home -mtime -7    # Modified in last 7 days

# Search and execute command
find . -name "*.log" -exec rm {} \;
```

### Locate
```bash
# Quick file search
locate file_name

# Update database
sudo updatedb
```

## Working with File Contents
### Viewing Contents
```bash
# View entire file
cat file.txt

# View with line numbers
nl file.txt

# View page by page
less file.txt

# View first/last lines
head -n 10 file.txt
tail -n 10 file.txt
```

### Modifying Contents
```bash
# Replace text
sed 's/old/new/g' file.txt

# Filter lines
grep "search_text" file.txt

# Count lines/words/characters
wc file.txt
```

## Permissions and Ownership
### Changing Permissions
```bash
# Change using numbers
chmod 755 file.txt

# Change using symbols
chmod u+x file.txt    # Add execute permission for owner
chmod go-w file.txt   # Remove write permission for group and others

# Recursive change
chmod -R 755 directory
```

### Changing Ownership
```bash
# Change owner
chown user file.txt

# Change owner and group
chown user:group file.txt

# Recursive change
chown -R user:group directory
```

## Compression and Archiving
### Tar
```bash
# Create archive
tar -czf archive.tar.gz directory/

# Extract archive
tar -xzf archive.tar.gz

# View archive contents
tar -tvf archive.tar.gz
```

### Zip/Unzip
```bash
# Create zip archive
zip -r archive.zip directory/

# Extract zip archive
unzip archive.zip

# View zip archive contents
unzip -l archive.zip
```

## Monitoring and Analysis
### Disk Usage
```bash
# Show directory sizes
du -sh *

# Show free space
df -h

# Disk usage analysis
ncdu /path
```

### File Checks
```bash
# Calculate checksum
md5sum file.txt
sha256sum file.txt

# Compare files
diff file1.txt file2.txt

# Check file type
file file
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'
alias du='du -h'
```

## Advanced Operations
```bash
# Find duplicate files
fdupes -r /path

# Directory synchronization
rsync -av source/ target/

# Secure deletion
shred -u file.txt

# Create symbolic link
ln -s target_file link_name
```