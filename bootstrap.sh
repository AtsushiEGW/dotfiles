#!/usr/bin/env sh
# ~/.dotfiles/bootstrap.sh
# できるだけ簡素。root でない/ sudo が無い時は OS パッケージ導入をスキップし、
# 代わりに dotfiles の配置と oh-my-zsh/プラグインの導入だけ行う。

set -eu

log() { printf '%s\n' "$*"; }
warn() { printf 'WARN: %s\n' "$*\n" >&2; }

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
ZSH_DIR="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$ZSH_DIR/custom"

# --- OS判定 ---
OS="$(uname -s 2>/dev/null || echo Unknown)"
DISTRO="linux"
[ "$OS" = "Darwin" ] && DISTRO="macos"

# --- sudo 使えるか ---
SUDO=""
if command -v sudo >/dev/null 2>&1 && [ "$(id -u)" != "0" ]; then
  SUDO="sudo"
fi

# --- 必要ならパッケージ（zsh, tmux, fzf, git） ---
install_pkgs() {
  case "$DISTRO" in
    macos)
      if ! command -v brew >/dev/null 2>&1; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi
      brew update
      brew install zsh tmux fzf git
      # fzf のキーバインド（再実行しても安全）
      "$(brew --prefix)/opt/fzf/install" --no-bash --no-fish --key-bindings --completion --no-update-rc 2>/dev/null || true
      ;;
    linux)
      if command -v apt-get >/dev/null 2>&1; then
        if [ -n "$SUDO" ] || [ "$(id -u)" = "0" ]; then
          $SUDO apt-get update -y
          $SUDO apt-get install -y --no-install-recommends zsh tmux fzf git ca-certificates
        else
          warn "apt-get を実行できないため OS パッケージ導入をスキップします"
        fi
      elif command -v apk >/dev/null 2>&1; then
        if [ -n "$SUDO" ] || [ "$(id -u)" = "0" ]; then
          $SUDO apk add --no-cache zsh tmux fzf git
        else
          warn "apk を実行できないため OS パッケージ導入をスキップします"
        fi
      fi
      ;;
    *)
      warn "未知の OS。パッケージ導入はスキップします"
      ;;
  esac
}

# --- oh-my-zsh 導入（未導入時のみ） ---
install_omz() {
  if [ ! -d "$ZSH_DIR" ]; then
    log "Installing oh-my-zsh..."
    # 非対話＆zsh未導入でもOKなようにshで実行
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
}

# --- プラグイン導入（autosuggestions / syntax-highlighting） ---
install_plugins() {
  mkdir -p "$ZSH_CUSTOM/plugins"
  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  fi
  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  fi
}

# --- シンボリックリンク（上書きOK・再実行安全） ---
link() {
  # usage: link SRC DST
  mkdir -p "$(dirname "$2")"
  ln -snf "$1" "$2"
}

link_dotfiles() {
  link "$DOTFILES/zsh/.zshrc"        "$HOME/.zshrc"
  link "$DOTFILES/zsh/aliases.zsh"   "$HOME/.zsh_aliases"
  link "$DOTFILES/zsh/options.zsh"   "$HOME/.zsh_options"
  link "$DOTFILES/tmux/.tmux.conf"   "$HOME/.tmux.conf"
  link "$DOTFILES/fzf/fzf.zsh"       "$HOME/.fzf.zsh"
}

# --- 実行 ---
install_pkgs
install_omz
install_plugins
link_dotfiles

log "Done. 新しいシェルで反映（例: exec zsh またはターミナル再起動）"