# ~/.zshrc - oh-my-zsh ベース（シンプル）
export LANG=${LANG:-en_US.UTF-8}

# PATH（ユーザ系を少し前に）
typeset -U path PATH
path=(
  $HOME/.local/bin
  $path
)
export PATH

# oh-my-zsh 本体
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"   # シンプルで等幅フォントでも崩れにくい
# プラグイン順序に注意：syntax-highlighting は最後
plugins=(
  git
  fzf
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# 別ファイル（再利用しやすく分割）
[ -f "$HOME/.zsh_options" ]  && source "$HOME/.zsh_options"
[ -f "$HOME/.zsh_aliases" ]  && source "$HOME/.zsh_aliases"

# fzf（未導入でも無害／macとLinux両対応）
# 1) デフォルト検索コマンド
if (( $+commands[rg] )); then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git"'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
elif (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
else
  export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/.git/*"'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --inline-info --cycle'

# 2) キーバインド/補完（Homebrew or distro or ユーザ）
if [[ -f "/usr/share/doc/fzf/examples/key-bindings.zsh" ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
elif [[ -f "/usr/share/fzf/key-bindings.zsh" ]]; then
  source /usr/share/fzf/key-bindings.zsh
elif command -v brew >/dev/null 2>&1 && [[ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ]]; then
  source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
elif [[ -f "$HOME/.fzf.zsh" ]]; then
  source "$HOME/.fzf.zsh"
fi

# 補足： oh-my-zsh の fzf プラグインは存在チェックだけ。上の key-bindings で十分です。