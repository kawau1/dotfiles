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

## Mac便利コマンド

* マウス感度高速化
```
defaults write -g com.apple.mouse.scaling 10
```

* 隠しファイル表示永続化
```
defaults write com.apple.finder AppleShowAllFiles -boolean true; killall Finder
```

* sudo Touch ID化
```
sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
sudo sh -c 'echo "auth sufficient pam_tid.so" > /etc/pam.d/sudo_local'
```


## リンク

* <https://brew.sh/ja/>
* <https://ohmyz.sh>
