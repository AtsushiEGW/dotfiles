# ls（GNU/BSD で分岐）
if is_macos; then
  alias ls='ls -G -F'
  alias ll='ls -alGh'
  alias la='ls -A'
else
  alias ls='ls --color=auto -F'
  alias ll='ls -alh --color=auto'
  alias la='ls -A --color=auto'
fi

# grep/cat
alias grep='grep --color=auto'
if (( $+commands[bat] )); then
  alias cat='bat -pp'
elif (( $+commands[batcat] )); then
  alias cat='batcat -pp'
fi

# 安全系
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Git
alias g='git'
alias gs='git status'
alias gst='git status -sb'
alias gco='git checkout'
alias ga='git add -A'
alias gc='git commit'
alias gca='git commit --amend --no-edit'
alias gp='git push'
alias gpl='git pull --rebase'
alias gsw='git switch'
alias gcb='git checkout -b'

# tmux
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tls='tmux ls'

# mac 専用 update（brew がある時だけ）
if command -v brew >/dev/null 2>&1; then
  alias update='brew update && brew upgrade && brew cleanup'
fi

# クリップボード
if is_macos; then
  alias clip='pbcopy'
else
  alias clip='xclip -selection clipboard'
fi

# Docker
alias d='docker'
alias dc='docker compose'

# Python
alias py='python'
alias pipi='python -m pip install -U pip'

# パス移動
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias duh='du -sh * | sort -h'

alias please='sudo'  # タイプミス救済

# fzf があるときの簡易関数（zoxide 無い時のみ）
if (( $+commands[fzf] )) && ! (( $+commands[zoxide] )); then
  ff() { find . -type f -not -path '*/.git/*' | fzf }
  fd() { cd "$(find "${1:-.}" -type d -not -path '*/.git/*' | fzf)"; }
fi