# Yay - Useful Commands

## Basic Operations
### Package Installation
```bash
# Install package from AUR
yay -S package_name

# Install without confirmation
yay -S --noconfirm package_name

# Install with provider selection
yay -S package_name --ask
```

### System Update
```bash
# Update all packages (including AUR)
yay -Syu

# Update only AUR packages
yay -Sua

# Force update database and packages
yay -Syyu
```

## Searching
```bash
# Search for package in AUR
yay -Ss keyword

# Show package information
yay -Si package_name

# Search for package with detailed output
yay -Ss --sortby popularity keyword
```

## System Maintenance
```bash
# Clean up unnecessary dependencies
yay -Yc

# Clean cache
yay -Sc

# Clean all caches
yay -Scc

# Remove orphaned packages
yay -Yns $(yay -Qtdq)
```

## Working with Source Code
```bash
# Download PKGBUILD without installation
yay -G package_name

# Edit PKGBUILD before installation
yay -S package_name --editmenu

# Show package dependencies
yay -Si package_name
```

## Advanced Options
```bash
# Install with custom parameters
yay -S package_name --mflags "--skipchecksums --skippgpcheck"

# Synchronize and update with package selection
yay -Syu --menu

# Export list of installed AUR packages
yay -Qm > aur_packages.txt
```

## Configuration
```bash
# Show AUR statistics
yay -P --stats

# Set editor for PKGBUILD
yay --editor vim

# Set diff viewer
yay --diffedit
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias yayin='yay -S'              # Install
alias yayss='yay -Ss'            # Search
alias yaysyu='yay -Syu'          # Update
alias yaysyyu='yay -Syyu'        # Force update
```

## Troubleshooting
```bash
# Reinstall package
yay -S --rebuildall package_name

# Check for conflicts
yay -Pk

# Force installation
yay -S --overwrite "*" package_name
```