#!/bin/sh

# Homebrewのインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# https://brew.sh/ja/

echo "Homebrew installation has completed!"

brew update
brew upgrade
brew cleanup

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

brew install --cask sf-symbols
brew install --cask rectangle
brew install --cask deepl
brew install --cask visual-studio-code
brew install --cask notion
brew install --cask sketch
brew install --cask minecraft
brew install --cask steam
brew install --cask discord

echo "All installations have completed!"
