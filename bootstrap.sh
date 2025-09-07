#!/usr/bin/env sh
# ~/.dotfiles/bootstrap.sh
# 最小権限で安全・再実行可能な初期化。sudo不可環境ではOSパッケージ導入をスキップし、
# dotfiles配置と oh-my-zsh / プラグイン導入のみ行う。

set -eu

log() { printf '%s\n' "$*"; }
warn() { printf 'WARN: %s\n' "$*"; }

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
ZSH_DIR="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$ZSH_DIR/custom"

OS="$(uname -s 2>/dev/null || echo Unknown)"
DISTRO="linux"
[ "$OS" = "Darwin" ] && DISTRO="macos"

SUDO=""
if command -v sudo >/dev/null 2>&1 && [ "$(id -u)" != "0" ]; then
  SUDO="sudo"
fi

install_pkgs() {
  case "$DISTRO" in
    macos)
      if ! command -v brew >/dev/null 2>&1; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi
      brew update
      # 実用度向上のために rg/fd/curl も入れる
      brew install zsh tmux fzf git ripgrep fd curl
      # fzf のキーバインド（再実行安全）
      "$(brew --prefix)/opt/fzf/install" --no-bash --no-fish --key-bindings --completion --no-update-rc 2>/dev/null || true
      ;;
    linux)
      if command -v apt-get >/dev/null 2>&1; then
        if [ -n "$SUDO" ] || [ "$(id -u)" = "0" ]; then
          export DEBIAN_FRONTEND=noninteractive
          $SUDO apt-get update -y
          $SUDO apt-get install -y --no-install-recommends \
            zsh tmux fzf git ca-certificates curl ripgrep fd-find
          # Debian/Ubuntu は fd-find のコマンド名が fdfind なのでエイリアスを用意（存在時のみ）
          if command -v fdfind >/dev/null 2>&1 && [ ! -e "$HOME/.local/bin/fd" ]; then
            mkdir -p "$HOME/.local/bin"
            ln -snf "$(command -v fdfind)" "$HOME/.local/bin/fd"
          fi
        else
          warn "apt-get を実行できないため OS パッケージ導入をスキップします"
        fi
      elif command -v apk >/dev/null 2>&1; then
        if [ -n "$SUDO" ] || [ "$(id -u)" = "0" ]; then
          $SUDO apk add --no-cache zsh tmux fzf git ca-certificates curl ripgrep fd
        else
          warn "apk を実行できないため OS パッケージ導入をスキップします"
        fi
      else
        warn "対応していないパッケージマネージャです（導入スキップ）"
      fi
      ;;
    *)
      warn "未知の OS。パッケージ導入はスキップします"
      ;;
  esac
}

install_omz() {
  if [ ! -d "$ZSH_DIR" ]; then
    log "Installing oh-my-zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
}

install_plugins() {
  mkdir -p "$ZSH_CUSTOM/plugins"
  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  fi
  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  fi
}

link() {
  # usage: link SRC DST   （SRC が存在する時だけ貼る）
  if [ -e "$1" ]; then
    mkdir -p "$(dirname "$2")"
    ln -snf "$1" "$2"
  else
    warn "リンク元が見つかりません: $1 （スキップ）"
  fi
}

link_dotfiles() {
  link "$DOTFILES/zsh/.zshrc"        "$HOME/.zshrc"
  link "$DOTFILES/zsh/aliases.zsh"   "$HOME/.zsh_aliases"
  link "$DOTFILES/zsh/options.zsh"   "$HOME/.zsh_options"
  link "$DOTFILES/tmux/.tmux.conf"   "$HOME/.tmux.conf"
  # $DOTFILES/fzf/fzf.zsh は不要（.zshrc が自動検出読み込み）
}

install_pkgs
install_omz
install_plugins
link_dotfiles

log "Done. 反映するには新しいシェルを開始してください（例: exec zsh）"