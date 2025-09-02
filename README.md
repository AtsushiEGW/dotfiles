# Dotfiles

Mac と Linux コンテナで同じ操作感を得るための最小構成の dotfiles です。  
使用しているツールは **zsh / oh-my-zsh / tmux / fzf** です。  
zsh には autosuggestions / syntax-highlighting プラグインを導入しています。

---

## 構成

```
~/.dotfiles/
├── bootstrap.sh       # 初期セットアップスクリプト
├── zsh
│   ├── .zshrc         # zsh のメイン設定
│   ├── aliases.zsh    # エイリアス
│   └── options.zsh    # zsh のオプション
├── tmux
│   └── .tmux.conf     # tmux 設定
└── fzf
    └── fzf.zsh        # fzf の追加設定（任意）
```

---

## セットアップ

### 1. リポジトリを配置
```
git clone https://github.com/yourname/dotfiles.git ~/.dotfiles
```

### 2. 初期化
```
sh ~/.dotfiles/bootstrap.sh
```

- Mac では Homebrew を使って zsh / tmux / fzf をインストールします。
- Linux では apt / apk が利用できればインストールします。権限が無ければスキップします。
- oh-my-zsh が導入され、autosuggestions / syntax-highlighting プラグインが追加されます。
- 各設定ファイルがホームディレクトリにシンボリックリンクされます。

### 3. シェルを再起動
```
exec zsh
```

---

## 利用ツール

- **zsh**: メインシェル。oh-my-zsh を利用。
  - プラグイン:
    - zsh-autosuggestions
    - zsh-syntax-highlighting
    - fzf (ある場合)
- **tmux**: ターミナルマルチプレクサ。
- **fzf**: 補完・ファイル検索。ripgrep / fd があれば自動で利用。

---

## カスタマイズ

- エイリアスは `zsh/aliases.zsh` にまとめています。
- zsh オプションは `zsh/options.zsh` で調整できます。
- tmux のプレフィックスキーやステータスラインは `tmux/.tmux.conf` を変更してください。
- fzf のデフォルト動作を上書きしたい場合は `fzf/fzf.zsh` に追記してください。

---

## 再実行について

`bootstrap.sh` は **再実行しても安全**です。  
パッケージ導入・oh-my-zsh・プラグイン導入・リンク作成は冪等に処理されます。

---

## 注意

- 本番用の軽量コンテナには導入せず、**開発用コンテナとローカル開発環境の統一**に使うことを想定しています。
- パッケージの追加が必要な場合は **Dockerfile に入れるのが推奨**です。
