#!/usr/bin/env sh
# ~/.dotfiles/install/common.sh
set -eu

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

log() { printf '%s\n' "$*"; }

[ -d "$DOTFILES_DIR" ] || { echo "ERROR: dotfiles dir not found: $DOTFILES_DIR" >&2; exit 1; }

# --- zinit（Zshプラグインマネージャ。oh-my-zsh不要） ---
if [ ! -d "$HOME/.zinit/bin" ]; then
  mkdir -p "$HOME/.zinit"
  if command -v git >/dev/null 2>&1; then
    git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$HOME/.zinit/bin"
  else
    echo "WARN: git not found; skip zinit clone" >&2
  fi
fi

# --- ユーティリティ: シンボリックリンク ---
link() {
  # link SRC DST
  mkdir -p "$(dirname "$2")"
  ln -snf "$1" "$2"
}

# --- Zsh 設定をリンク ---
if [ -f "$DOTFILES_DIR/zsh/zshrc" ]; then
  link "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
else
  echo "WARN: $DOTFILES_DIR/zsh/zshrc not found; skip linking ~/.zshrc" >&2
fi

# --- Starship 設定（存在する場合のみ） ---
if [ -f "$DOTFILES_DIR/starship/starship.toml" ]; then
  mkdir -p "$HOME/.config"
  link "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
else
  log "INFO: starship config not found; skipped"
fi

# --- tmux 設定（.tmux.conf を優先） ---
TMUX_SRC=""
if [ -f "$DOTFILES_DIR/tmux/.tmux.conf" ]; then
  TMUX_SRC="$DOTFILES_DIR/tmux/.tmux.conf"
elif [ -f "$DOTFILES_DIR/tmux/tmux.conf" ]; then
  TMUX_SRC="$DOTFILES_DIR/tmux/tmux.conf"
fi
[ -n "$TMUX_SRC" ] && link "$TMUX_SRC" "$HOME/.tmux.conf" || log "INFO: tmux config not found; skipped"


# --- 可能ならログインシェルを zsh に（コンテナではスキップ） ---
is_container() {
  [ -f /run/.containerenv ] || [ -f /.dockerenv ]
}

if command -v zsh >/dev/null 2>&1 && command -v chsh >/dev/null 2>&1; then
  if ! is_container; then
    case "${SHELL:-}" in
      *zsh) : ;;  # すでに zsh
      *) chsh -s "$(command -v zsh)" || true ;;
    esac
  else
    echo "[common] container detected; skip chsh (devcontainer feature will set default shell)."
  fi
fi

echo "[common] linking finished. Open a new shell or run: exec zsh"