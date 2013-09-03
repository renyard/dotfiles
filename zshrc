# If not running interactively, don't do anything.
[[ -z "$PS1" ]] && return

# Set defaults
EDITOR=vim

# Add script dir to PATH.
export PATH=/usr/local/bin:$PATH:$DIR/bin

# Tab completion
autoload -U compinit
compinit

# Tab completion from both ends
setopt completeinword

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Better completion for killall
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

# Spelling correction
setopt correct
setopt correctall

# Shared history for all shells
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt incappendhistory 
setopt sharehistory
setopt extendedhistory

# Ignore dupes in history
setopt histignoredups

# Display CPU usage for commands taking longer than 10 seconds
export REPORTTIME=10

# VCS info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git cvs svn

precmd() {
	vcs_info 'prompt'
}

# Custom prompt
PS1="[%n@%m %~]${vcs_info_msg_0_}$ "

# Misc. options
setopt auto_cd

. ~/dotfiles/aliases
