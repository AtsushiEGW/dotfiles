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
    

# === Quick note/memo launchers (journal & memo, monthly folders) =========

_note_open_with_vscode() {
  if command -v code >/dev/null 2>&1; then
    code "$1"
  else
    printf 'WARN: VS Code CLI "code" が見つかりませんでした。PATH を確認してください。\n' >&2
    return 127
  fi
}

# w-note: ~/note/journal/yyyy-mm/yyyymmdd.md を（なければ作成して）開く
_journal_impl() {
  local dir="${HOME}/note/journal/$(date +%Y-%m)"
  local fname="$(date +%Y%m%d).md"
  local file="${dir}/${fname}"

  mkdir -p "$dir"
  if [[ ! -e "$file" ]]; then
    echo "# $(date +%Y-%m-%d) Journal" > "$file"
  fi

  _note_open_with_vscode "$file"
}

# w-memo: ~/note/memo/yyyy-mm/yyyymmdd_hhmmss.md を毎回作成して開く
_memo_impl() {
  local dir="${HOME}/note/memo/$(date +%Y-%m)"
  local stamp_date="$(date +%Y-%m-%d)"
  local stamp_time="$(date +%H:%M:%S)"
  local fname="$(date +%Y%m%d_%H%M%S).md"
  local file="${dir}/${fname}"

  mkdir -p "$dir"
  echo "# ${stamp_date} ${stamp_time} Memo" > "$file"

  _note_open_with_vscode "$file"
}

alias journal='_journal_impl'
alias memo='_memo_impl'