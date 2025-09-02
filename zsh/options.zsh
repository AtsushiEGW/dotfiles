# ~/.zsh_options

setopt AUTO_MENU AUTO_LIST MENU_COMPLETE
setopt INTERACTIVE_COMMENTS
setopt BANG_HIST EXTENDED_HISTORY INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_VERIFY
HISTFILE="$HOME/.zsh_history"
HISTSIZE=200000
SAVEHIST=200000

# completion 見た目（重たくならない最小限）
zmodload zsh/complist 2>/dev/null || true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'