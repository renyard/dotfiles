# If not running interactively, don't do anything.
[[ -z "$PS1" ]] && return

# Get the script path.
DOTFILES_DIR="$( cd "$( dirname "$0" )" && pwd )"

if [ -f $DOTFILES_DIR/zsh_functions ]; then
	. $DOTFILES_DIR/zsh_functions
fi

# Set defaults.
EDITOR=vim
bindkey -e

# Add script dir to PATH.
export PATH=/usr/local/bin:/usr/local/share/npm/bin:$PATH:$DIR/bin

# Tab completion
autoload -U compinit
compinit

# Tab completion from both ends.
setopt completeinword

# Case insensitive completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Better completion for killall.
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

# Spelling correction.
setopt correct
setopt correctall

# Shared history for all shells.
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt incappendhistory 
setopt sharehistory
setopt extendedhistory

# Ignore dupes and commands starting with a space in history.
setopt histignorealldups
setopt histignorespace

# Display CPU usage for commands taking longer than 10 seconds.
export REPORTTIME=10

# VCS info.
if function_exists vcs_info; then
	autoload -Uz vcs_info
	zstyle ':vcs_info:*' enable git svn

	precmd() {
		vcs_info 'prompt'
	}
fi

# Custom prompt.
setopt prompt_subst
PS1="[%n@%m %c]${vcs_info_msg_0_}$ "

# Misc. options.
setopt auto_cd

if [ -f $DOTFILES_DIR/aliases ]; then
	. $DOTFILES_DIR/aliases
fi
