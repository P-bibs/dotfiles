#!/bin/sh

if [[ $EUID -eq 0 ]]; then
  echo "Do not run this script as root, it needs to know the user's home directory" 1>&2
  exit 1
fi

# expect two arguments, directory of this repo and either "ubuntu" or "arch"
if [ $# -ne 1 ]; then
    echo "Usage: ./install.sh <dotfile_directory> <ubuntu|arch>"
    exit 1
fi
dotfile_directory=$1
distro=$2
if [ $distro != "ubuntu" ] && [ $distro != "arch" ]; then
    echo "Usage: ./install.sh <dotfile_directory> <ubuntu|arch>"
    exit 1
fi

# install arch packages
if [ $distro == "arch" ]; then
  sudo pacman -S zsh tmux neovim ripgrep fzf git-delta bat trash-put
  mkdir ~/Builds
  cd ~/Builds
  git clone https://aur.archlinux.org/yay.git
  cd yay
  sudo makepkg -si
  yay -S spotify dropbox nerd-fonts-fira-code google-chrome zoom teamviewer visual-studio-code-bin powerline-fonts-git simplescreenrecorder
fi

# install ubuntu packages
if [ $distro == "ubuntu" ]; then
    # we have to install all these packages manually because Ubuntu sucks and
    # bundles old versions
    
    # install zsh
    echo "Installing zsh..."
    if ! [ -x "$(command -v zsh)" ]; then
      echo 'Error: zsh is not installed.'
      echo '\tzsh installation on ubuntu varies based on permissions.'
      echo '\tInstall zsh and then re-run this script to continue.'
      exit 1
    fi

    # install neovim
    echo "Installing neovim..."
    mkdir -p ${HOME}/Builds/nvim
    cd ${HOME}/Builds/nvim
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
    tar xzf nvim-linux64.tar.gz

    # install nodejs
    echo "Installing nodejs..."
    curl -L https://bit.ly/n-install | bash

    # install tmux
    echo "Installing tmux..."
    mkdir -p ${HOME}/Builds/tmux
    cd ${HOME}/Builds/tmux
    wget https://github.com/nelsonenzo/tmux-appimage/releases/download/3.3a/tmux.appimage
    mv tmux.appimage tmux
    chmod +x tmux

    # install delta
    echo "Installing delta..."
    mkdir -p ${HOME}/Builds/delta
    cd ${HOME}/Builds/delta
    wget https://github.com/dandavison/delta/releases/download/0.16.5/delta-0.16.5-x86_64-unknown-linux-gnu.tar.gz
    tar xzf delta-0.16.5-x86_64-unknown-linux-gnu.tar.gz

    # install bat
    echo "Installing bat..."
    mkdir -p ${HOME}/Builds/bat
    cd ${HOME}/Builds/bat
    wget https://github.com/sharkdp/bat/releases/download/v0.23.0/bat-v0.23.0-x86_64-unknown-linux-gnu.tar.gz
    tar xzf bat-v0.23.0-x86_64-unknown-linux-gnu.tar.gz

    # install ripgrep
    echo "Installing ripgrep..."
    mkdir -p ${HOME}/Builds/ripgrep
    cd ${HOME}/Builds/ripgrep
    wget https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
    tar xzf ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
fi

cd ${HOME}

# install oh my zsh and plugins
echo "Installing oh-my-zsh..."
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install vim-plug
echo "Installing vim-plug..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install tmux plugin manager (tpm)
echo "Installing tpm..."
mkdir -p ~/.config/tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# create symlinks to dotfiles
echo "Creating dotfile symlinks..."
cd ${HOME}
ln -s ${dotfile_directory}/.zshrc ${HOME}/.zshrc
ln -s ${dotfile_directory}/.tmux.conf ${HOME}/.config/tmux/tmux.conf
ln -s ${dotfile_directory}/init.vim ${HOME}/.config/nvim/init.vim
ln -s ${dotfile_directory}/.gitconfig ${HOME}/.gitconfig

# create symlinks to binaries
echo "Creating binary symlinks..."
cd ${HOME}/.local/bin
ln -s ${HOME}/Builds/nvim/nvim-linux64/bin/nvim .
ln -s ${HOME}/Builds/tmux/tmux .
ln -s ${HOME}/Builds/delta/delta-0.16.5-x86_64-unknown-linux-gnu/delta .
ln -s ${HOME}/Builds/bat/bat-v0.23.0-x86_64-unknown-linux-gnu/bat .
ln -s ${HOME}/Builds/ripgrep/ripgrep-13.0.0-x86_64-unknown-linux-musl/rg .

# finishing up steps
echo "Only a few manual steps left:"
echo "1. Change your shell to zsh using `chsh`"
echo "2. Relogin to make sure changes take effect"
