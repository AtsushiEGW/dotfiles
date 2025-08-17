# 読み込み高速化
zinit ice wait"1" lucid

# 補完拡張
zinit light zsh-users/zsh-completions

# シンタックスハイライト（高速系）
zinit light zdharma-continuum/fast-syntax-highlighting

# 入力サジェスト
zinit light zsh-users/zsh-autosuggestions

# 履歴の部分一致検索（↑/↓）
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# fzf-tab（fzf がある時だけ）
if command -v fzf >/dev/null 2>&1; then
  zinit light Aloxaf/fzf-tab
  # 使いやすい切替キー例：グループ間移動
  zstyle ':fzf-tab:*' switch-group 'ctrl-h' 'ctrl-l'
fi