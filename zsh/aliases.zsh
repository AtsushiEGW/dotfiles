# 最小の共通エイリアス
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias gs='git status -sb'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'

alias v='nvim'
alias t='tmux'

alias upd='brew update && brew upgrade'

case "$(uname -s)" in
    Darwin)
        # macOS
        alias upd='brew update && brew upgrade'
        ;;
    Linux)
        # Linux (WSL, docker container 含む)
        alias upd='sudo apt-get update && sudo apt-get upgrade -y'
        ;;
esac
    

