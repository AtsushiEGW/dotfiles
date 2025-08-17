#!/usr/bin/env sh
# ~/.dotfiles/install/macos.sh  (POSIX sh)
set -eu

# --- Homebrew ---
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew update

# --- Brewfile ---
if [ -f "$HOME/.dotfiles/Brewfile" ]; then
  brew bundle --file="$HOME/.dotfiles/Brewfile"
fi

# --- fzf キーバインド (brew 版) ---
FZF_INSTALL="$(brew --prefix 2>/dev/null)/opt/fzf/install"
if [ -x "$FZF_INSTALL" ]; then
  yes | "$FZF_INSTALL" --no-bash --no-fish
fi