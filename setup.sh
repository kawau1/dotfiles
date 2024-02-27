#!/bin/sh

# Homebrewのインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# https://brew.sh/ja/

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
brew install openjdk
sudo ln -sfn $(brew --prefix)/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
brew install gh
gh auth login
gh extension install github/gh-copilot
gh extention install kawarimidoll/gh-graph
gh extension upgrade --all
brew install vim

brew tap homebrew/cask-fonts
brew install --cask font-monaspace
brew install --cask font-sf-pro
brew install --cask font-sf-compact
brew install --cask font-sf-mono
brew install --cask font-new-york

brew install --cask appcleaner
brew install --cask sf-symbols
brew install --cask docker
brew install --cask wine-stable
brew install --cask rectangle
brew install --cask hhkb
brew install --cask deepl
brew install --cask visual-studio-code
brew install --cask notion
brew install --cask minecraft
brew install --cask steam
brew install --cask discord

echo "All installations have completed!"
