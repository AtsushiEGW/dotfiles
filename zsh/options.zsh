# ~/.zsh_options

# 補完とメニュー
setopt AUTO_MENU AUTO_LIST MENU_COMPLETE
zmodload zsh/complist 2>/dev/null || true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select   # ← 矢印で候補を選べる

# コメント/履歴
setopt INTERACTIVE_COMMENTS
setopt BANG_HIST EXTENDED_HISTORY INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_VERIFY
HISTFILE="$HOME/.zsh_history"
HISTSIZE=200000
SAVEHIST=200000