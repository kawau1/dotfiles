#!/bin/sh

# フォントのインストール
# ダウンロードするDMGファイルのURLリスト
DMG_URLS=(
    "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg"
    "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg"
    "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg"
    "https://devimages-cdn.apple.com/design/resources/download/NY.dmg"
)

# 各URLに対してループ処理
for DMG_URL in "${DMG_URLS[@]}"; do
    # DMGファイルを保存する一時的な場所
    DMG_FILE="/tmp/font.dmg"

    # ダウンロード
    curl -o "$DMG_FILE" "$DMG_URL"

    # DMGファイルのマウント
    MOUNT_POINT=$(hdiutil attach "$DMG_FILE" | grep "Volumes" | awk '{print $3}')

    # .ttf と .otf フォントファイルのコピー
    cp "$MOUNT_POINT"/*.ttf ~/Library/Fonts/
    cp "$MOUNT_POINT"/*.otf ~/Library/Fonts/

    # DMGのアンマウント
    hdiutil detach "$MOUNT_POINT"

    echo "The font has been installed:$DMG_URL"
done

echo "All fonts have been installed!"


# Homebrewのインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# https://brew.sh/ja/

echo "Homebrew installation has completed!"

# Homebrewでインストールするアプリケーション
brew install ffmpeg
brew install yt-dlp
brew install gh
# gh auth login
# gh extension install github/gh-copilot
# gh textention install kawarimidoll/gh-graph
brew install vim
brew tap homebrew/cask-fonts
brew install font-monaspace
brew install --cask visual-studio-code
brew install --cask notion
brew install --cask sketch
brew install --cask steam

echo "All installations have completed!"
