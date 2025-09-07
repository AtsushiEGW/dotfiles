# 履歴設定（十分に大きく）
HISTFILE="$HOME/.zsh_history"
HISTSIZE=200000
SAVEHIST=200000
setopt share_history hist_ignore_dups hist_reduce_blanks

# よく使う最小オプション
setopt autocd            # "cd" 省略
setopt interactive_comments
setopt glob_dots         # .ファイルも補完対象

# 補完（oh-my-zshがcompinitを呼ぶが、破損時の再構築にも耐える）
autoload -Uz compinit
if [ ! -f ~/.zcompdump ] || ! zcompdump -t ~/.zcompdump >/dev/null 2>&1; then
  compinit -C
else
  compinit -u
fi
zstyle ':completion:*' menu select