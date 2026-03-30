# dotfiles

## 概要

```
dotfiles/
├─ .claude/
│  ├─ CLAUDE.md
│  ├─ settings.json
│  └─ statusline.json
├─ .conf/
│  ├─ tmux.conf (~/.config/tmux/)
│  └─ yt-dlp.conf (~/.config/yt-dlp/)
├─ .zsh/
│  ├─ .p10k.zsh
│  ├─ .zshrc
│  └─ aliases.zsh (~/.oh-my-zsh/custom/)
├─ coding agent/
│  ├─ AGENTS.md
│  ├─ config.toml (~/.codex/)
│  └─ settings.json (~/.gemini/)
├─ .vimrc
├─ brew_setup.sh
├─ install.sh
└─ link.sh
```

## インストール手順

1. リポジトリをクローン:

   ```bash
   git clone https://github.com/kawau1/dotfiles.git
   ```

2. インストールスクリプトを実行:

   ```bash
   cd ./dotfiles
   chmod +x ./install.sh
   sh ./install.sh
   ```

## メモ
* 設定ファイルをWindowsで使用する場合、改行コードをCRLFに変換する

## リンク

* <https://brew.sh/ja/>
* <https://ohmyz.sh>
