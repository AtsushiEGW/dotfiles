# 読み込み高速化のデフォルト ice
zinit ice wait"1" lucid

# --- 1) 補完関数を先に読み込み（compinit 前に fpath を揃える） ---
zinit light zsh-users/zsh-completions

# compinit 相当：zinit の仕組みで実行（これで補完が有効化される）
zicompinit
zicdreplay

# --- 2) 補完後に読み込む系（UI/ハイライト/サジェストなど） ---
# シンタックスハイライト（高速）
zinit light zdharma-continuum/fast-syntax-highlighting

# 入力サジェスト
zinit light zsh-users/zsh-autosuggestions

# 履歴の部分一致検索（↑/↓）
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# fzf-tab（fzf がある時だけ）: 必ず compinit 後に読み込む
if command -v fzf >/dev/null 2>&1; then
  zinit light Aloxaf/fzf-tab
  # 好みのキーバインド例（グループ切替）
  zstyle ':fzf-tab:*' switch-group 'ctrl-h' 'ctrl-l'
fi