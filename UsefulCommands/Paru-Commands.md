# Paru - Useful Commands

## Basic Operations
### Package Installation
```bash
# Install package
paru -S package_name

# Install without confirmation
paru -S --noconfirm package_name

# Install only AUR packages
paru -Sa package_name
```

### System Update
```bash
# Update all packages
paru -Syu

# Update only AUR packages
paru -Sua

# Force update
paru -Syyu
```

## Searching
```bash
# Search for package
paru -Ss keyword

# Search only in AUR
paru -Sa keyword

# Show package information
paru -Si package_name
```

## Package Management
```bash
# Remove package
paru -R package_name

# Remove package and dependencies
paru -Rs package_name

# Clean cache
paru -Sc

# Clean all caches
paru -Scc
```

## Working with Source Code
```bash
# Download PKGBUILD
paru -G package_name

# Show PKGBUILD
paru -Gp package_name

# Edit PKGBUILD before installation
PARU_EDITOR=vim paru -S package_name
```

## Advanced Features
```bash
# Show Arch Linux news
paru -Pw

# Show package dependencies
paru -Si package_name

# Check for updates without installing
paru -Qu
```

## System Maintenance
```bash
# List orphaned packages
paru -Qtd

# Remove orphaned packages
paru -Rns $(paru -Qtdq)

# Check for system issues
paru -Dk
```

## Useful Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias pain='paru -S'              # Install
alias pass='paru -Ss'            # Search
alias paup='paru -Syu'           # Update
alias paupf='paru -Syyu'         # Force update
```

## Troubleshooting
```bash
# Rebuild package
paru -S --rebuildall package_name

# Force installation
paru -S --overwrite "*" package_name

# Debug mode
PARU_DEBUG=1 paru -S package_name
```