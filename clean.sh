#!/usr/bin/env bash
set -euo pipefail

echo "[1/4] Killing running nvim instances (if any)..."
pkill -x nvim 2>/dev/null || true

echo "[2/4] Backing up existing config (if present)..."
if [ ! command -v rsync ] >/dev/null 2>&1; then
    echo "rsync not found. Skipping backup."
    exit 0
fi

backup_dir="$HOME/.config/nvim.bak.$(date +%s)"

if [ -d "$HOME/.config/nvim" ]; then
    rsync -a --delete "$HOME/.config/nvim" "$backup_dir"
    echo "Backup created at: $backup_dir"
fi

echo "[3/4] Removing Neovim data, cache and state..."
rm -rf "$HOME/.local/share/nvim"
rm -rf "$HOME/.cache/nvim"
rm -rf "$HOME/.local/state/nvim"

echo "Done. Next steps:"
echo "1. Recreate ~/.config/nvim (init.lua + plugins)"
echo "2. Run: nvim"
echo "3. Lazy will bootstrap and install plugins automatically"
