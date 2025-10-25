#!/bin/sh

# Homebrewのインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Homebrewのセットアップスクリプトを実行
chmod +x ./brew_setup.sh
sh ./brew_setup.sh

# Oh My Zshのインストール
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# シンボリックリンクを貼るスクリプトを実行
chmod +x ./link.sh
sh ./link.sh

# カーソルのスピードを変更
defaults write -g com.apple.mouse.scaling 8
# defaults read -g com.apple.mouse.scaling で確認
# 再起動で有効化
# 隠しファイルを常に表示
defaults write com.apple.finder AppleShowAllFiles -bool true
killall Finder
