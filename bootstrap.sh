#!/usr/bin/env sh
# ~/.dotfiles/bootstrap.sh  (POSIX)
set -eu

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
INSTALL_DIR="$DOTFILES_DIR/install"

log() { printf '%s\n' "$*"; }
err() { printf 'ERROR: %s\n' "$*\n" >&2; exit 1; }

[ -d "$DOTFILES_DIR" ] || err "dotfiles dir not found: $DOTFILES_DIR"
[ -d "$INSTALL_DIR" ]  || err "install dir not found: $INSTALL_DIR"

# --- Detect distro (POSIX) ---
OS_UNAME="$(uname -s 2>/dev/null || echo Unknown)"
DISTRO="debian"
if [ "$OS_UNAME" = "Darwin" ]; then
  DISTRO="macos"
elif [ "$OS_UNAME" = "Linux" ] && [ -r /etc/os-release ]; then
  . /etc/os-release
  case "${ID:-}${ID_LIKE:+ $ID_LIKE}" in
    *alpine*|*Alpine*) DISTRO="alpine" ;;
    *)                 DISTRO="debian" ;;
  esac
fi

# --- Pick installer script ---
case "$DISTRO" in
  macos)  INSTALLER="$INSTALL_DIR/macos.sh"  ;;
  debian) INSTALLER="$INSTALL_DIR/debian.sh" ;;
  alpine) INSTALLER="$INSTALL_DIR/alpine.sh" ;;
  *)      err "unknown DISTRO: $DISTRO" ;;
esac

if [ "$DISTRO" = "macos" ] && [ ! -f "$INSTALLER" ]; then
  log "macos installer not found. skipping platform install…"
else
  [ -f "$INSTALLER" ] || err "installer not found: $INSTALLER"
  chmod +x "$INSTALLER" 2>/dev/null || true
  log "→ Running installer: $INSTALLER"
  # macOS は内部で bash を使うが、ここは sh で OK
  if [ "$DISTRO" = "macos" ]; then
    /bin/bash "$INSTALLER"
  else
    sh "$INSTALLER"
  fi
fi

# --- Common (links / zinit / starship.toml etc.) ---
if [ -f "$INSTALL_DIR/common.sh" ]; then
  chmod +x "$INSTALL_DIR/common.sh" 2>/dev/null || true
  sh "$INSTALL_DIR/common.sh"
fi

log "[dotfiles] setup done."