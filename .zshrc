# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

# Automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  git clone --quiet https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

plugins=(git zsh-autosuggestions wd)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


# Custom prompt additions to override theme (put prompt on newline and bold commands)
PROMPT="${PROMPT}"$'\n'"%{$fg_bold[blue]%}➤ %{$reset_color%}"

export PATH="$PATH":"$HOME/dotfiles/Scripts"

# Add Rust package manager dirs to PATH
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"$HOME/.cargo/bin"

# Add ruby gems to PATH
export PATH="$PATH":"$HOME/.gem/ruby/2.7.0/bin"
export PATH="$PATH":"$HOME/.local/share/gem/ruby/3.0.0/bin"
export PATH="$PATH":"$HOME/.rbenv/versions/2.6.7/bin"

export PATH="$PATH":"$HOME/builds/racket/bin"

# set default editor to neovim
export EDITOR="nvim"

# Start MATLAB on the command line
alias matlabnd="matlab -nojvm -nodisplay -nosplash"

# opam configuration
test -r ${HOME}/.opam/opam-init/init.zsh && . ${HOME}/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# nodejs version manager (n) configuration
export N_PREFIX=${HOME}/n
export PATH="${N_PREFIX}/bin:$PATH"

eval "$(github-copilot-cli alias -- "$0")"

export PATH="${HOME}/.local/bin:$PATH"

alias please='echo $(fc -ln -1) ; sudo $(fc -ln -1)'
alias scratch="mkdir /tmp/scratch; touch /tmp/scratch/scratch; code /tmp/scratch"
alias scratchn="mkdir /tmp/scratch; touch /tmp/scratch/scratch; nvim /tmp/scratch/scratch"
alias trash="trash-put"
alias zshconfig="$EDITOR ~/.zshrc"
