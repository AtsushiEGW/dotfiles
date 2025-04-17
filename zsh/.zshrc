# history
HISTFILE=~/.zsh_history
HISTSIZ=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

# Acrivate zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Activate zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Alias
alias vim="nvim"
alias vi="nvim"
alias upd="brew update && brew upgrade"
alias uvupd="uv self update && uv lock --upgrade && uv sync && uv cache prune"

. "$HOME/.local/bin/env"

# path each workingspace
export PATH="$PATH:$HOME/workspace/my_awesomebook/.venv/bin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# starship
eval "$(starship init zsh)"
