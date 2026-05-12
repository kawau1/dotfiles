#!/bin/bash

# Homebrewのインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Homebrewのセットアップスクリプトを実行
chmod +x ./brew_setup.sh
bash ./brew_setup.sh

# Oh My Zshのインストール
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# シンボリックリンクを貼るスクリプトを実行
chmod +x ./link.sh
bash ./link.sh

# カーソルのスピードを変更
defaults write -g com.apple.mouse.scaling 8
# defaults read -g com.apple.mouse.scaling で確認
# 再起動で有効化

# 隠しファイルを常に表示
defaults write com.apple.finder AppleShowAllFiles -bool true
killall Finder

# sudo Touch ID化
sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
sudo sh -c 'echo "auth sufficient pam_tid.so" > /etc/pam.d/sudo_local'
