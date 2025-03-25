# Pacman - Useful Commands

## Basic Operations
### Package Installation
```bash
# Install single package
pacman -S package_name

# Install multiple packages
pacman -S package1 package2

# Install without confirmation
pacman -S --noconfirm package_name
```

### Package Removal
```bash
# Remove package
pacman -R package_name

# Remove package and its dependencies
pacman -Rs package_name

# Remove package, dependencies, and configuration files
pacman -Rns package_name
```

### System Update
```bash
# Synchronize database
pacman -Sy

# Update all packages
pacman -Syu

# Force update
pacman -Syyu
```

## Searching
```bash
# Search for package
pacman -Ss keyword

# Search for locally installed package
pacman -Qs keyword

# Show package information
pacman -Si package_name

# Show information about installed package
pacman -Qi package_name
```

## Maintenance
```bash
# Clean package cache
pacman -Sc

# Clean all caches
pacman -Scc

# List orphaned packages
pacman -Qdt

# Remove orphaned packages
pacman -Rns $(pacman -Qtdq)
```

## Troubleshooting
```bash
# Check database issues
pacman -Dk

# Fix database
pacman -Dk --fix

# Force package installation
pacman -S --overwrite "*" package_name
```

## Advanced Usage
```bash
# Export list of explicitly installed packages
pacman -Qe > packages.txt

# Install packages from list
pacman -S --needed - < packages.txt

# Show reverse dependencies
pacman -Sii package_name
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias pacupg='sudo pacman -Syu'        # Upgrade
alias pacin='sudo pacman -S'           # Install
alias pacrem='sudo pacman -Rns'        # Remove
alias pacss='pacman -Ss'               # Search
alias pacsyu='sudo pacman -Syyu'       # Force sync and upgrade
```