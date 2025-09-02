# ~/.zsh_aliases

# OS 判定ヘルパ
is_macos() { [[ "$OSTYPE" == darwin* ]]; }

# ls
if is_macos; then
  alias ls='ls -G -F'
  alias ll='ls -alGh'
else
  alias ls='ls --color=auto -F'
  alias ll='ls -alh --color=auto'
fi
alias la='ls -A'

# grep/cat
alias grep='grep --color=auto'

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
alias gp='git push'
alias gpl='git pull --rebase'

# tmux
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tls='tmux ls'

# クリップボード
if is_macos; then
  alias clip='pbcopy'
elif command -v xclip >/dev/null 2>&1; then
  alias clip='xclip -selection clipboard'
fi

# パス移動
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'