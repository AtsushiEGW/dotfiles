# 補完/メニュー系（compinit 自体は zshrc で実行済み or zinit が最適化して実行）
setopt AUTO_MENU AUTO_LIST MENU_COMPLETE COMPLETE_IN_WORD
setopt NO_BEEP INTERACTIVE_COMMENTS
setopt AUTO_CD           # ただのパス入力で cd
setopt CORRECT           # 軽い補正
setopt NO_FLOW_CONTROL   # Ctrl+S/Q 無効（誤爆防止）
setopt EXTENDED_GLOB

# 補完の見た目/挙動
zmodload zsh/complist 2>/dev/null || true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'