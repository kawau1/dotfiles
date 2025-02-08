#!/bin/sh

# Homebrewのインストール
# https://brew.sh/ja/
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


brew update
brew upgrade
brew cleanup
brew autoremove
brew tap homebrew/autoupdate
brew autoupdate start 86400 --upgrade --cleanup --immediate --sudo

# Homebrewでインストールするアプリケーション
brew install git
brew install ffmpeg
brew install yt-dlp
brew install neofetch
brew install wget
brew install python
brew install pyenv
brew install openjdk
sudo ln -sfn $(brew --prefix)/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
brew install gh
gh auth login
gh extension install github/gh-copilot
gh extention install kawarimidoll/gh-graph
gh extension install roistaff/gh-info
gh extension upgrade --all
brew install prettier
brew install vim
brew install zsh-autocomplete
brew install zsh-syntax-highlighting
# source $(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# .zshrcに追記する

brew tap homebrew/cask-fonts
brew install --cask font-monaspace
brew install --cask font-sf-pro
brew install --cask font-sf-compact
brew install --cask font-sf-mono
brew install --cask font-new-york
brew install --cask font-noto-sans-jp
brew install --cask font-noto-serif-jp

brew install --cask sf-symbols
brew install --cask chatgpt
brew install --cask github-copilot-for-xcode
brew install --cask docker
brew install --cask parallels
brew install --cask parallels-toolbox
brew install --cask hhkb
brew install --cask deepl
brew install --cask microsoft-edge
brew install --cask visual-studio-code
brew install --cask notion
brew install --cask steam
brew install --cask minecraft
brew install --cask nvidia-geforce-now
brew install --cask discord
