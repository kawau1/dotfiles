# dotfiles

## 概要

```
dotfiles/
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
├─ link.sh
└─ yt-dlp.conf (~/.config/yt-dlp/)
```

## インストール手順

1. リポジトリをクローンする:

   ```bash
   git clone https://github.com/kawau1/dotfiles.git
   ```

2. インストールスクリプトを実行する:

   ```bash
   cd ./dotfiles
   chmod +x ./install.sh
   sh ./install.sh
   ```

## メモ
* 設定ファイルをWindowsで使用する場合、改行コードをCRLFに変換すること

## リンク

* <https://brew.sh/ja/>
* <https://ohmyz.sh>
