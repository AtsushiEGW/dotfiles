#!/usr/bin/env sh
# ~/.dotfiles/install/alpine.sh (POSIX)
set -eu

# apk は通常 root 実行。sudo があれば使うが、無ければそのまま
SUDO=""; command -v sudo >/dev/null 2>&1 && SUDO="sudo"

$SUDO apk update
$SUDO apk add --no-cache zsh curl git ca-certificates fzf tmux xclip

# starship（musl 用バイナリ直置き）— 失敗しても続行
if ! command -v starship >/dev/null 2>&1; then
  ARCH="$(uname -m)"
  case "$ARCH" in
    x86_64)  URL="https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-musl.tar.gz" ;;
    aarch64) URL="https://github.com/starship/starship/releases/latest/download/starship-aarch64-unknown-linux-musl.tar.gz" ;;
    *) echo "unsupported arch: $ARCH"; exit 0 ;;
  esac
  TMP="$(mktemp -d)"
  if curl -fsSL "$URL" | tar xz -C "$TMP"; then
    TARGET_DIR="/usr/local/bin"
    if [ ! -w "$TARGET_DIR" ]; then
      TARGET_DIR="$HOME/.local/bin"
      mkdir -p "$TARGET_DIR"
    else
      $SUDO mkdir -p "$TARGET_DIR"
    fi
    if [ "$TARGET_DIR" = "/usr/local/bin" ]; then
      $SUDO install -m 0755 "$TMP/starship" "$TARGET_DIR/starship"
    else
      install -m 0755 "$TMP/starship" "$TARGET_DIR/starship"
    fi
  fi
  rm -rf "$TMP"
fi