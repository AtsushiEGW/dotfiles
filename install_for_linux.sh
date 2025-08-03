#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

install_packages() {
  echo "→ 必要なパッケージをインストール…"
  if command -v apt-get &>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y \
      git tmux fzf curl \
      fonts-powerline \
      # fzf, starship は公式リポジトリで新しければ
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y \
      git zsh tmux fzf starship curl
  else
    echo "対応していないパッケージマネージャです。" >&2
    exit 1
  fi
}

install_zsh_plugins() {
  echo "→ Zsh プラグインをセットアップ…"
  ZSH_PLUGIN_DIR="$HOME/.zsh"
  mkdir -p "$ZSH_PLUGIN_DIR"
  # zsh-autosuggestions
  if [ ! -d "$ZSH_PLUGIN_DIR/zsh-autosuggestions" ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git \
      "$ZSH_PLUGIN_DIR/zsh-autosuggestions"
  fi
  # zsh-syntax-highlighting
  if [ ! -d "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting" ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
      "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting"
  fi
}

install_starship() {
  if ! command -v starship &>/dev/null; then
    echo "→ Starship をインストール…"
    curl -fsSL https://starship.rs/install.sh | sh -s -- -y
    export PATH="$HOME/.cargo/bin:$PATH"
  fi
}



link_dotfiles() {
  echo "→ dotfiles のシンボリックリンクを作成…"
  ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
  ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
}


main() {
  install_packages
  install_zsh_plugins
  install_starship
  link_dotfiles

  echo
  echo "🎉 Linux 環境（apt＋zsh＋starship＋tmux＋fzf＋プラグイン）がセットアップされました！"
}

main "$@"