# dotfiles

このリポジトリでは、zsh と tmux の設定を dotfiles で管理し、任意のマシンで一発で環境構築できるようにしています。

---

## 📁 ディレクトリ構成

    ~/.dotfiles/
    ├── zsh/
    │   └── .zshrc         # zsh 設定ファイル
    ├── tmux/
    │   └── .tmux.conf     # tmux 設定ファイル
    ├── install_for_linux.sh  # Linux 環境用インストーラ
    └── install-macos.sh   # macOS (Homebrew) 環境用インストーラ

---

## ⚙️ 必要要件

- Git  
- zsh  
- tmux  
- fzf  
- curl  

Linux では `apt` または `dnf`、macOS では Homebrew を利用してください。

---

## 🚀 インストール方法

### Linux 環境

    # リポジトリをクローン
    git clone https://github.com/<ユーザー名>/dotfiles.git ~/dotfiles
    cd ~/dotfiles

    # スクリプト実行
    chmod +x install.sh
    ./install.sh

### macOS (Homebrew) 環境

    # リポジトリをクローン
    git clone https://github.com/<ユーザー名>/dotfiles.git ~/dotfiles
    cd ~/dotfiles

    # スクリプト実行
    chmod +x install-macos.sh
    ./install-macos.sh

---

## 🔗 dotfiles の中身

- **zsh/.zshrc**: Oh My Zsh の設定とプラグイン（autosuggestions, syntax-highlighting, fzf）  
- **tmux/.tmux.conf**: tmux のキーバインド変更（Ctrl+a）、ステータスバー設定、マウス有効化  

---

## 🛠️ 使い方

1. ターミナルを再起動すると、自動的に zsh が起動します。  
2. `Ctrl+a` で tmux のプレフィックスキーが有効化されます。  
3. fzf を使ったファイル・コマンド補完が動作します。  

---

## ✏️ カスタマイズ

- **zsh テーマ**: `zsh/.zshrc` 内の `ZSH_THEME` を変更  
- **プラグイン追加**: `~/.oh-my-zsh/custom/plugins` にクローンし、`.zshrc` の `plugins=(...)` に追加  
- **tmux 設定**: `tmux/.tmux.conf` を編集  

---

## 🔄 更新方法

1. `cd ~/dotfiles` でリポジトリに移動  
2. `git pull` で最新化  
3. 必要に応じて `install.sh` や `install-macos.sh` を再実行  

---

## 📄 ライセンス

MIT License


### Homebrew インストール後の設定設定

```plain
==> Next steps:
- Run these commands in your terminal to add Homebrew to your PATH:
    echo >> /home/dev/.bashrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/dev/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
- Install Homebrew's dependencies if you have sudo access:
    sudo apt-get install build-essential
  For more information, see:
    https://docs.brew.sh/Homebrew-on-Linux
- We recommend that you install GCC:
    brew install gcc
```