# ~/.zshrc

# 共通設定（ヒストリ、エイリアスなど）
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

alias ll='ls -la'
alias gs='git status'
alias ta='tmux attach -t'
alias tn='tmux new -s'

# --- OS判定 ---
OS_TYPE="$(uname -s)"

if [ "$OS_TYPE" = "Darwin" ]; then
  # ======== macOS の場合 ========
  
  # Homebrew 環境をロード
  if command -v brew &>/dev/null; then
    eval "$(brew shellenv)"
  fi

  # starship（brewでインストール推奨）
  if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
  fi

  # fzf (Homebrew版)
  if [ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ]; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
  fi
  if [ -f "$(brew --prefix)/opt/fzf/shell/completion.zsh" ]; then
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
  fi

  # zsh-autosuggestions（Homebrew）
  if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  fi

  # zsh-syntax-highlighting（Homebrew）
  if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  fi

  # macOS固有のalias例
  alias clip='pbcopy'


else
  # ======== Linux の場合 ========

  # starship（手動インストールやcargo経由）
  export PATH="$HOME/.cargo/bin:$PATH"
  if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
  fi

  # fzf (aptや手動インストール)
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

  # zsh-autosuggestions（Git clone版）
  if [ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
  fi

  # zsh-syntax-highlighting（Git clone版）
  if [ -f "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  fi

  # Linux固有のalias例
  alias clip='xclip -selection clipboard'

fi