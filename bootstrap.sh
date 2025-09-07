#!/usr/bin/env sh
# ~/.dotfiles/bootstrap.sh
# 最小セットアップ: sudo不要・再実行安全・リンク作成・oh-my-zsh導入・VS Code CLIリンク

set -eu

log()  { printf '[dotfiles] %s\n' "$*"; }
warn() { printf 'WARN: %s\n' "$*\n" >&2; }

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

# -------- OS/環境判定 --------
IS_MACOS=false; IS_LINUX=false; IS_WSL=false; IS_CONTAINER=false
case "$(uname -s)" in
  Darwin) IS_MACOS=true ;;
  Linux)  IS_LINUX=true ;;
esac
# WSL
if $IS_LINUX && grep -qiE '(microsoft|wsl)' /proc/version 2>/dev/null; then
  IS_WSL=true
fi
# コンテナ（簡易）
if grep -qE '(docker|containerd)' /proc/1/cgroup 2>/dev/null; then
  IS_CONTAINER=true
fi

# -------- ユーティリティ --------
link() {
  src="$1"; dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv -f "$dst" "$dst.bak.$(date +%s)"
    log "backup: $dst -> ${dst}.bak.*"
  fi
  ln -snf "$src" "$dst"
  log "linked: $dst -> $src"
}

install_ohmyzsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "installing oh-my-zsh (non-interactive)"
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
}

install_min_plugins() {
  ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  mkdir -p "$ZSH_CUSTOM/plugins"
  [ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  [ -d "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" ] || \
    git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
  [ -d "$ZSH_CUSTOM/plugins/zsh-completions" ] || \
    git clone --depth=1 https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
}

# ~/.zsh/local.zsh を先読み（WIN_USER を参照したい）
load_local_vars() {
  # まだ ~/.zsh へリンクしていない段階でも読みたいので両方見る
  if [ -f "$HOME/.zsh/local.zsh" ]; then
    # 変数を環境へエクスポート
    # local.zsh は "export VAR=..." の形式にしてください
    # shellcheck disable=SC1090
    . "$HOME/.zsh/local.zsh"
  elif [ -f "$DOTFILES/zsh/local.zsh" ]; then
    # 万一直置きしている場合
    # shellcheck disable=SC1090
    . "$DOTFILES/zsh/local.zsh"
  fi
}

link_code_cli() {
  # 既に PATH 上にあるなら触らない
  if command -v code >/dev/null 2>&1; then
    log "code already in PATH: $(command -v code)"
    return 0
  fi

  # コンテナはスキップ（Windowsの VS Code から接続する想定）
  if $IS_CONTAINER; then
    log "container detected: skip linking VS Code CLI"
    return 0
  fi

  src=""
  if $IS_MACOS; then
    mac_path="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
    [ -x "$mac_path" ] && src="$mac_path"
  elif $IS_WSL; then
    if [ -z "${WIN_USER:-}" ]; then
      warn "WIN_USER not set (define it in ~/.zsh/local.zsh like: export WIN_USER=\"YourWindowsUser\")"
    else
      guess="/mnt/c/Users/$WIN_USER/AppData/Local/Programs/Microsoft VS Code/bin/code"
      if [ -x "$guess" ]; then
        src="$guess"
      else
        warn "VS Code CLI not found at $guess — please adjust manually."
      fi
    fi
  fi

  if [ -n "${src:-}" ]; then
    mkdir -p "$HOME/.local/bin"
    link "$src" "$HOME/.local/bin/code"
  fi
}

main() {
  install_ohmyzsh
  install_min_plugins
  load_local_vars

  mkdir -p "$HOME/.local/bin"

  # zsh
  link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
  link "$DOTFILES/zsh" "$HOME/.zsh"

  # git
  link "$DOTFILES/git/gitconfig"        "$HOME/.gitconfig"
  link "$DOTFILES/git/gitignore_global" "$HOME/.gitignore_global"

  # tmux
  link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

  # VS Code CLI
  link_code_cli

  log "done. restart shell or run: exec zsh"
}

main "$@"