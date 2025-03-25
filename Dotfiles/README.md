# Dotfiles

This folder contains configuration files for various applications and tools. These files can be used for quick system setup.
(This is still a work in progress)

## Folder Structure

```
dotfiles/
├── bash/
│   ├── .bashrc
│   ├── .bash_profile
│   └── .bash_aliases
├── zsh/
│   ├── .zshrc
│   ├── .zprofile
│   └── .zsh_aliases
├── vim/
│   ├── .vimrc
│   └── .vim/
├── tmux/
│   └── .tmux.conf
├── git/
│   ├── .gitconfig
│   └── .gitignore_global
├── config/
│   ├── i3/
│   ├── polybar/
│   └── rofi/
└── scripts/
    ├── backup.sh
    └── update.sh
```

## Usage

### Manual Copying
```bash
cp -r dotfiles/bash/ ~/
cp -r dotfiles/vim/ ~/
```

### Using Symlinks
```bash
ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
ln -s ~/dotfiles/vim/.vimrc ~/.vimrc
```

### Automated Deployment
```bash
# Script for deploying dotfiles
#!/bin/bash
for file in $(find ~/dotfiles -name ".*"); do
    ln -sf $file ~/$(basename $file)
done
```

## File Contents

### .bashrc
```bash
# Basic settings
export EDITOR=vim
export VISUAL=vim

# Aliases
alias ll='ls -la'
alias update='sudo pacman -Syu'
alias clean='sudo pacman -Rns $(pacman -Qtdq)'

# Prompt
PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '
```

### .vimrc
```vim
" Basic settings
set number
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
syntax on

" Key bindings
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q<CR>
```

### .tmux.conf
```tmux
# Basic settings
set -g mouse on
set -g base-index 1
set -g pane-base-index 1

# Key bindings
bind-key C new-window
bind-key x kill-pane
```

### .gitconfig
```git
[core]
    editor = vim
    excludesfile = ~/.gitignore_global
[alias]
    co = checkout
    ci = commit
    st = status
    br = branch
    hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short
```

## Useful Scripts

### backup.sh
```bash
#!/bin/bash
# Backup important files
tar -czf backup_$(date +%F).tar.gz \
    ~/.bashrc \
    ~/.vimrc \
    ~/.tmux.conf \
    ~/.gitconfig
```

### update.sh
```bash
#!/bin/bash
# System and dotfiles update
sudo pacman -Syu
cd ~/dotfiles
git pull origin main
```

## Synchronization Between Systems

### Using Git
```bash
# Initialize repository
cd ~/dotfiles
git init
git remote add origin https://github.com/user/dotfiles.git

# Push changes
git add .
git commit -m "Update dotfiles"
git push origin main

# Pull changes
git pull origin main
```

## Best Practices

1. **Versioning**
   - Use Git for change management
   - Commit changes regularly
   - Use meaningful commit messages

2. **Modularity**
   - Split configurations into logical units
   - Use conditional blocks for different systems

3. **Documentation**
   - Comment important parts of configurations
   - Keep the README up to date
   - Record changes in CHANGELOG

## References
- [Arch Wiki - Dotfiles](https://wiki.archlinux.org/title/Dotfiles)
- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
- [Dotfiles GitHub](https://dotfiles.github.io/)
