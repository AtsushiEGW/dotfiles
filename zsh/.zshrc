# ~/.zshrc - oh-my-zsh ベース（シンプル & 高速）
export LANG=${LANG:-en_US.UTF-8}

# 非インタラクティブなら早期終了（CI等で速く）
[[ $- != *i* ]] && return

# Homebrew (Apple Silicon) の PATH を自動付与
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# PATH（ユーザ系を少し前に）
typeset -U path PATH
path=(
  $HOME/.local/bin
  $path
)
export PATH

# oh-my-zsh 本体
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gnzh"   # 等幅でも崩れにくいシンプルなテーマ

# プラグイン（syntax-highlighting は最後にすること！）
plugins=(
  git
  fzf
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# 追加オプション／エイリアス（分割読み込み）
[ -f "$HOME/.zsh_options" ]  && source "$HOME/.zsh_options"
[ -f "$HOME/.zsh_aliases" ]  && source "$HOME/.zsh_aliases"

# autosuggestions の挙動（履歴優先で軽快）
export ZSH_AUTOSUGGEST_STRATEGY=history
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"   # 長すぎるコマンドは提案しない(任意)

# fzf：検索ソースの自動選択（rg > fd > find）
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
# 見やすいUI。--inline-info は古いので --info=inline を使う
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --info=inline --cycle'

# fzf キーバインド/補完（環境に合わせて自動）
if [[ -f "/usr/share/doc/fzf/examples/key-bindings.zsh" ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
elif [[ -f "/usr/share/fzf/key-bindings.zsh" ]]; then
  source /usr/share/fzf/key-bindings.zsh
elif command -v brew >/dev/null 2>&1 && [[ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ]]; then
  source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
elif [[ -f "$HOME/.fzf.zsh" ]]; then
  source "$HOME/.fzf.zsh"
fi

# 補足：oh-my-zsh の fzf plugin は存在チェック目的。上の key-bindings で十分。