# Dotfiles

<p align="center">
<img src="preview.png">
</p>

## Required Packages

- oh-my-zsh
  - `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- `neovim`
  - `sudo pacman -S neovim`
- `vim-plug`
  - ```
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    ```
- `tmux`
  - `sudo pacman -S tmux`
- Gogh (Gnome Terminal Themes)
  - Install Misterioso for dark theme and Google Light for light theme
  - `bash -c "$(wget -qO- https://git.io/vQgMr)"`
- `ripgrep`
  - for fuzzy searching files within neovim
  - `sudo pacman -S ripgrep`

## Create symlinks

```bash
cd ~
DIR=path/to/this/directory
ln -s $DIR/.zshrc ~/.zshrc
ln -s $DIR/.tmux.conf ~/.tmux.conf
ln -s $DIR/init.vim ~/.config/nvim/init.vim
```

## Install neovim plugings

```bash
# execute this within neovim
:PlugInstall
```

## VSCode snippets
```bash
ln -s $DIR/snippets ~/.config/Code/user/snippets
```
