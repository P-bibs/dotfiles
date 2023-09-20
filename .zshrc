# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/paul/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions wd)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Custom prompt additions to override theme (put prompt on newline and bold commands)
PROMPT="${PROMPT}"$'\n'"%{$fg_bold[blue]%}➤ %{$reset_color%}"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias please='echo $(fc -ln -1) ; sudo $(fc -ln -1)'
alias pyfypi_up="curl pyfypi.devices.brown.edu:3001/start\?key=BrunoBoy"
alias pyfypi_down="curl pyfypi.devices.brown.edu:3001/stop\?key=BrunoBoy"
alias scratch="mkdir /tmp/scratch; touch /tmp/scratch/scratch; code /tmp/scratch"
alias scratchn="mkdir /tmp/scratch; touch /tmp/scratch/scratch; nvim /tmp/scratch/scratch"

alias c="cd ~/Dropbox\ \(Brown\)/Brown/Sophomore"
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

# alias docker-compose
alias d-c="docker-compose"

# add ardviz start script
alias ardviz="/home/paul/Dropbox\ \(Brown\)/Personal/Projects/ArdViz/cava_method/start.sh"

# opam configuration
test -r /home/paul/.opam/opam-init/init.zsh && . /home/paul/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# don't record commands temporarily when entering dangerous commands
# alias incognito="if set | grep ^history$; then set -o history && echo 'history off'; else set +o history && echo 'history on'; fi"


eval "$(github-copilot-cli alias -- "$0")"

export PATH="/home/paul/.local/bin:$PATH"
