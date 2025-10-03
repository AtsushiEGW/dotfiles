# ~/.dotfiles/zsh/zshrc  （~/.zshrc からこのファイルへリンク）
# ZDOTDIR で ~/.zsh 以下に分割ファイルをまとめる
export ZDOTDIR="$HOME/.zsh"

# oh-my-zsh（付属テーマをそのまま使う）
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="gnzh"
ZSH_THEME="eastwood"
plugins=(git zsh-completions zsh-autosuggestions fast-syntax-highlighting)

source "$ZSH/oh-my-zsh.sh"

# 分割設定の読み込み（順序はファイル名で制御）
for f in env.zsh options.zsh aliases.zsh local.zsh; do
  [ -r "$ZDOTDIR/$f" ] && source "$ZDOTDIR/$f"
done

# fzf が入っていれば oh-my-zsh のフックが自動で効く（.fzf.zsh 等）
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
