#!/usr/bin/env sh
# ~/.dotfiles/install/debian.sh (POSIX)
set -eu

# sudo を必要時のみ
SUDO=""
if command -v sudo >/dev/null 2>&1 && [ "$(id -u)" != "0" ]; then
  SUDO="sudo"
fi

# 非対話で（devcontainer で詰まらないように）
export DEBIAN_FRONTEND=noninteractive

$SUDO apt-get update -y
$SUDO apt-get install -y --no-install-recommends \
  zsh curl git ca-certificates fzf tmux xclip locales

# ロケール（存在する環境でのみ）
if [ -f /etc/locale.gen ] && command -v locale-gen >/dev/null 2>&1; then
  if grep -q '^# *en_US\.UTF-8 UTF-8' /etc/locale.gen; then
    $SUDO sed -i 's/^# *en_US\.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen || true
  elif ! grep -q '^en_US\.UTF-8 UTF-8' /etc/locale.gen; then
    $SUDO sh -c "printf '%s\n' 'en_US.UTF-8 UTF-8' >> /etc/locale.gen"
  fi
  $SUDO locale-gen || true
fi

# starship（失敗しても続行）
if ! command -v starship >/dev/null 2>&1; then
  (curl -fsSL https://starship.rs/install.sh | sh -s -- -y) || true
fi