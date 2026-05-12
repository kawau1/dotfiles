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
| `.claude/CLAUDE.md` | `~/.claude/CLAUDE.md` |
| `.claude/settings.json` | `~/.claude/settings.json` |
| `.claude/statusline.py` | `~/.claude/statusline.py` |
| `.conf/tmux.conf` | `~/.config/tmux/tmux.conf` |
| `.conf/yt-dlp.conf` | `~/.config/yt-dlp/yt-dlp.conf` |
| `.zsh/.zshrc` | `~/.zshrc` |
| `.zsh/.p10k.zsh` | `~/.p10k.zsh` |
| `.zsh/aliases.zsh` | `~/.oh-my-zsh/custom/aliases.zsh` |
| `coding agent/config.toml` | `~/.codex/config.toml` |
| `coding agent/settings.json` | `~/.gemini/settings.json` |
| `coding agent/AGENTS.md` | `~/.codex/AGENTS.md`, `~/.gemini/AGENTS.md` |
| `.vimrc` | `~/.vimrc` |

## インストール手順

1. リポジトリをクローン:

   ```bash
   git clone https://github.com/kawau1/dotfiles.git
   ```

2. インストールスクリプトを実行:

   ```bash
   cd ./dotfiles
   bash ./install.sh
   ```

## メモ
* 設定ファイルをWindowsで使用する場合、改行コードをCRLFに変換する

## Mac便利コマンド

* マウス感度高速化
```
defaults write -g com.apple.mouse.scaling 8
```

* 隠しファイル表示永続化
```
defaults write com.apple.finder AppleShowAllFiles -boolean true
killall Finder
```

* sudo Touch ID化
```
sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
sudo sh -c 'echo "auth sufficient pam_tid.so" > /etc/pam.d/sudo_local'
```


## リンク

* <https://brew.sh/ja/>
* <https://ohmyz.sh>
