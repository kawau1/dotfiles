#!/bin/sh

brew update
brew upgrade
brew cleanup
brew autoremove
brew tap homebrew/autoupdate
brew autoupdate start 86400 --upgrade --cleanup --immediate --sudo

brew install git
brew install ffmpeg
brew install yt-dlp
brew install imagemagick
brew install ollama
brew services start ollama
brew install codex
brew install gemini-cli
brew install neofetch
brew install python
brew install gh
# gh auth login
brew install prettier
brew install vim
brew install powerlevel10k
brew install zsh-autocomplete
brew install zsh-syntax-highlighting

brew tap homebrew/cask-fonts
brew install --cask font-monaspace
brew install --cask font-monaspace-var
brew install --cask font-monaspace-nf
brew install --cask font-sf-pro
brew install --cask font-sf-compact
brew install --cask font-sf-mono
brew install --cask font-new-york
brew install --cask font-noto-sans-jp

brew install --cask iterm2
brew install --cask sf-symbols
brew install --cask chatgpt
brew install --cask chatgpt-atlas
brew install --cask github-copilot-for-xcode
brew install --cask docker
brew install --cask parallels
brew install --cask parallels-toolbox
brew install --cask hhkb
brew install --cask deepl
# brew install --cask microsoft-edge
# brew install --cask microsoft-office
brew install --cask visual-studio-code
brew install --cask notion
brew install --cask obsidian
brew install --cask steam
brew install --cask minecraft
brew install --cask nvidia-geforce-now
brew install --cask discord
brew install --cask cmd-eikana
brew install --cask logi-options+
