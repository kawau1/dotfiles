# dotfiles

## 概要

```
dotfiles/
├─ .claude/
│  ├─ CLAUDE.md
│  ├─ settings.json
│  └─ statusline.py
├─ .conf/
│  ├─ tmux.conf
│  └─ yt-dlp.conf
├─ .zsh/
│  ├─ .p10k.zsh
│  ├─ .zshrc
│  └─ aliases.zsh
├─ coding agent/
│  ├─ AGENTS.md
│  ├─ config.toml
│  └─ settings.json
├─ .vimrc
├─ brew_setup.sh
├─ install.sh
└─ link.sh
```
## リンク先

| リポジトリ内 | 配置先 |
|---|---|
| `.vimrc` | `~/.vimrc` |
| `.zsh/.zshrc` | `~/.zshrc` |
| `.zsh/.p10k.zsh` | `~/.p10k.zsh` |
| `.zsh/aliases.zsh` | `~/.oh-my-zsh/custom/aliases.zsh` |
| `.conf/tmux.conf` | `~/.config/tmux/tmux.conf` |
| `.conf/yt-dlp.conf` | `~/.config/yt-dlp/config` |
| `.claude/CLAUDE.md` | `~/.claude/CLAUDE.md` |
| `.claude/settings.json` | `~/.claude/settings.json` |
| `.claude/statusline.py` | `~/.claude/statusline.py` |
| `coding agent/config.toml` | `~/.codex/config.toml` |
| `coding agent/settings.json` | `~/.gemini/settings.json` |

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
