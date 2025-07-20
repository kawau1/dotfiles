# dotfiles

## Tree Diagram

```
dotfiles/
├─ .vimrc
├─ .zshrc
│  └─ aliases.zsh (~/.oh-my-zsh/custom)
├─ .p10k.zsh
├─ yt-dlp.conf
├─ brew_setup.sh
└─ install.sh
```

## Installetion

1. Clone this repository:

   ```bash
   git clone https://github.com/kawau1/dotfiles.git
   ```

2. Run the installation script:

   ```bash
   cd dotfiles
   ./install.sh
   ```

3. If you want to use the Zsh theme, run the following command:

   ```bash
   cp .p10k.zsh ~/.p10k.zsh
   ```

4. If you want to use the Vim configuration, run the following command:

   ```bash
   cp .vimrc ~/.vimrc
   ```

5. If you want to use the Zsh aliases, run the following command:

   ```bash
   cp .zshrc ~/.zshrc
   cp aliases.zsh ~/.oh-my-zsh/custom/
    ```

6. If you want to use the yt-dlp configuration, run the following command:

   ```bash
    cp yt-dlp.conf ~/.config/yt-dlp/
    ```

## Links

<https://brew.sh/ja/>
<https://ohmyz.sh>
