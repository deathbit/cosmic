#!/bin/bash
# install.sh - Install dotfiles to home directory (supports bash and zsh)
# Usage: bash install.sh or zsh install.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
HOME_DIR="$HOME"
BACKUP_DIR="$HOME_DIR/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

DOTFILES=(
    .bash_profile
    .bashrc
    .gitconfig
    .shell_profile
    .shellrc
    .vimrc
    .zprofile
    .zshrc
)

echo "Installing dotfiles from $SCRIPT_DIR to $HOME_DIR ..."
echo "Existing files will be backed up to $BACKUP_DIR"

installed=0
skipped=0

for file in "${DOTFILES[@]}"; do
    if [ -f "$SCRIPT_DIR/$file" ]; then
        if [ -f "$HOME_DIR/$file" ]; then
            mkdir -p "$BACKUP_DIR"
            cp "$HOME_DIR/$file" "$BACKUP_DIR/$file"
        fi
        cp -f "$SCRIPT_DIR/$file" "$HOME_DIR/$file"
        echo "  Installed: $file"
        installed=$((installed + 1))
    else
        echo "  Skipped (not found in repo): $file"
        skipped=$((skipped + 1))
    fi
done

echo "Done. Installed $installed file(s), skipped $skipped file(s)."
