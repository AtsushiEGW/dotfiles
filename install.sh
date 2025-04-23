#!/bin/bash

DOTFILES="$HOME/.dotfiles"

echo "🔗 Setting up dotfiles..."

# --------- ZSH ---------
if [ -f "$HOME/.zshrc" ] || [ -L "$HOME/.zshrc" ]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
    echo "🗂️  Backed up .zshrc to .zshrc.bak"
fi
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
echo "✅ Linked .zshrc"

# --------- Neovim ---------
mkdir -p "$HOME/.config"
if [ -e "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
    echo "🗂️  Backed up .config/nvim to .config/nvim.bak"
fi
ln -snf "$DOTFILES/nvim" "$HOME/.config/nvim"
echo "✅ Linked Neovim config"

# --------- Starship ---------
ln -sf "$DOTFILES/starship.toml" "$HOME/.config/starship.toml"
echo "✅ Linked starship.toml"

# --------- Tmux ---------
if [ -f "$HOME/.tmux.conf" ] || [ -L "$HOME/.tmux.conf" ]; then
    mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak"
    echo "🗂️  Backed up .tmux.conf to .tmux.conf.bak"
fi
ln -sf "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"
echo "✅ Linked .tmux.conf"

# --------- WezTerm ---------
ln -sf "$DOTFILES/wezterm/wezterm.lua" "$HOME/.wezterm.lua"
echo "✅ Linked wezterm.lua"

echo "🎉 All dotfiles linked successfully!"

#----------- VS Code ------------
VSCODE_USER="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_USER"

ln -sf "$HOME/.dofiles/vscode/settings.json" "$VSCODE_USER/settings.json"
ln -sf "$HOME/.dofiles/vscode/keybindings.json" "$VSCODE_USER/keybindings.json"

if [ -d "$HOME/.dotfiles/vscode/snippets"]; then
    ln -sfn "$HOME/.dotfiles/vscode/snippets" "$VSCODE_USER/snippets"
fi

echo "✅ Linked VSCode settings"
