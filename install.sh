#!/bin/bash
set -e

if [[ $EUID -eq 0 ]]; then
  echo "Do not run this script as root, it needs to know the user's home directory" 1>&2
  exit 1
fi

# expect two arguments, directory of this repo and either "ubuntu" or "arch"
if [ $# -ne 2 ]; then
    echo "Usage: ./install.sh <dotfile_directory> <ubuntu|arch>"
    exit 1
fi
dotfile_directory=$1
distro=$2
if [ $distro != "ubuntu" ] && [ $distro != "arch" ]; then
    echo "Usage: ./install.sh <dotfile_directory> <ubuntu|arch>"
    exit 1
fi

dotfile_directory=$(readlink -f $dotfile_directory)

# install arch packages
if [ $distro == "arch" ]; then
  sudo pacman -S zsh tmux neovim ripgrep fzf git-delta bat trash-put
  mkdir ${HOME}/Builds
  cd ${HOME}/Builds
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
      echo -e '\tzsh installation on ubuntu varies based on permissions.'
      echo -e '\tInstall zsh and then re-run this script to continue.'
      exit 1
    fi

    # install neovim
    echo "Installing neovim..."
    mkdir -p ${HOME}/Builds/nvim
    cd ${HOME}/Builds/nvim
    wget -q https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
    tar xzf nvim-linux64.tar.gz
    mkdir -p ${HOME}/.config/nvim

    # install nodejs
    echo "Installing nodejs..."
    if [ ! $(type -P "node") ]; then
      if [ ! -d "${HOME}/n" ]; then
        curl -L https://bit.ly/n-install | bash -s -- -y -n
      else
        echo -e "n version manager already installed, skipping."
      fi
    else
      echo -e "Nodejs already installed, skipping."
    fi

    # install tmux
    echo "Installing tmux..."
    mkdir -p ${HOME}/Builds/tmux
    cd ${HOME}/Builds/tmux
    wget -q https://github.com/nelsonenzo/tmux-appimage/releases/download/3.3a/tmux.appimage
    mv tmux.appimage tmux
    chmod +x tmux

    # install delta
    echo "Installing delta..."
    mkdir -p ${HOME}/Builds/delta
    cd ${HOME}/Builds/delta
    wget -q https://github.com/dandavison/delta/releases/download/0.16.5/delta-0.16.5-x86_64-unknown-linux-gnu.tar.gz
    tar xzf delta-0.16.5-x86_64-unknown-linux-gnu.tar.gz

    # install bat
    echo "Installing bat..."
    mkdir -p ${HOME}/Builds/bat
    cd ${HOME}/Builds/bat
    wget -q https://github.com/sharkdp/bat/releases/download/v0.23.0/bat-v0.23.0-x86_64-unknown-linux-gnu.tar.gz
    tar xzf bat-v0.23.0-x86_64-unknown-linux-gnu.tar.gz

    # install ripgrep
    echo "Installing ripgrep..."
    mkdir -p ${HOME}/Builds/ripgrep
    cd ${HOME}/Builds/ripgrep
    wget -q https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
    tar xzf ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
fi

cd ${HOME}

# install oh my zsh and plugins
echo "Installing oh-my-zsh..."
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo -e "Skipping, .oh-my-zsh already exists"
fi

# install vim-plug
echo "Installing vim-plug..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install tmux plugin manager (tpm)
echo "Installing tpm..."
mkdir -p ${HOME}/.config/tmux/plugins
if [ ! -d "${HOME}/.config/tmux/plugins/tpm" ]; then
  git clone --quiet https://github.com/tmux-plugins/tpm ${HOME}/.config/tmux/plugins/tpm
else
  echo "Skipping, already installed"
fi

# create symlinks to dotfiles
echo "Creating dotfile symlinks..."
cd ${HOME}
ln -sf ${dotfile_directory}/.zshrc ${HOME}/.zshrc
ln -sf ${dotfile_directory}/.tmux.conf ${HOME}/.config/tmux/tmux.conf
ln -sf ${dotfile_directory}/init.vim ${HOME}/.config/nvim/init.vim
ln -sf ${dotfile_directory}/.gitconfig ${HOME}/.gitconfig

# create symlinks to binaries
echo "Creating binary symlinks..."
mkdir -p ${HOME}/.local/bin
cd ${HOME}/.local/bin
ln -sf ${HOME}/Builds/nvim/nvim-linux64/bin/nvim .
ln -sf ${HOME}/Builds/tmux/tmux .
ln -sf ${HOME}/Builds/delta/delta-0.16.5-x86_64-unknown-linux-gnu/delta .
ln -sf ${HOME}/Builds/bat/bat-v0.23.0-x86_64-unknown-linux-gnu/bat .
ln -sf ${HOME}/Builds/ripgrep/ripgrep-13.0.0-x86_64-unknown-linux-musl/rg .

# finishing up steps
echo "Only a few manual steps left:"
echo "1. Change your shell to zsh using \`chsh\`"
echo "2. Relogin to make sure changes take effect"
