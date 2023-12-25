#!/bin/sh

# Homebrewのインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# https://brew.sh/ja/

echo "Homebrew installation has completed!"

brew update
brew upgrade

# Homebrewでインストールするアプリケーション
brew install ffmpeg
brew install yt-dlp
brew install gh
gh auth login
gh extension install github/gh-copilot
gh extention install kawarimidoll/gh-graph
gh extension upgrade --all
brew install vim

brew tap homebrew/cask-fonts
brew install --cask homebrew/cask-fonts/font-monaspace
brew install --cask homebrew/cask-fonts/font-sf-pro
brew install --cask homebrew/cask-fonts/font-sf-compact
brew install --cask homebrew/cask-fonts/font-sf-mono
brew install --cask homebrew/cask-fonts/font-new-york

brew install --cask sf-symbols
brew install --cask raspberry-pi-imager
brew install --cask docker
brew install --cask rectangle
brew install --cask visual-studio-code
brew install --cask notion
brew install --cask sketch
brew install --cask steam
brew install --cask discord

echo "All installations have completed!"
