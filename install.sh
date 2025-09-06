#!/bin/sh

# Xcode Command Line Toolsのインストール
xcode-select --install

# インストールが完了するまで待機
until xcode-select -p &>/dev/null; do
    sleep 5
done

# Homebrewのインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Homebrewのセットアップスクリプトを実行
sh ./brew_setup.sh

# Oh My Zshのインストール
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# シンボリックリンクを貼るスクリプトを実行
sh ./link.sh
