# Dotfiles (Minimal) — macOS / WSL / Docker

## Setup
```sh
git clone <YOUR-REPO> ~/.dotfiles
~/.dotfiles/bootstrap.sh
exec zsh

```

### What this does
- Installs oh-my-zsh (non-interactive) if missing
- Links zsh/git/tmux configs
- Optionally links VS Code CLI (code)
- macOS: /Applications/.../bin/code があればリンク
- WSL: ~/.zsh/local.zsh の WIN_USER から C:\Users\<WIN_USER>\... を探す
- Docker: スキップ（Windows の VS Code から接続する想定）

## Per-host overrides

### Create ~/.zsh/local.zsh (NOT in git):

```bash
export WIN_USER="Taro"  # only if you use WSL
# export PATH="$HOME/.cargo/bin:$PATH"
# export OPENAI_API_KEY="..."
```

### Packages (install outside this repo)
- zsh, git, tmux, neovim (+ optional: fzf, ripgrep, fd)
- macOS (Homebrew): brew install zsh git tmux neovim fzf ripgrep fd
- Ubuntu/WSL/Docker: apt-get update && apt-get install -y zsh git tmux neovim fzf ripgrep fd-find && ln -sf /usr/bin/fdfind /usr/local/bin/fd



