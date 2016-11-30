# If not running interactively, don't do anything.
[[ -z "$PS1" ]] && return

# Get the script path.
DF_DIR="$( cd "$( dirname "$0" )" && pwd )"

# Syntax highlighting config.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets root)

# Source oh my zsh config.
if [ -f $DF_DIR/oh-my-zshrc ]; then
	. $DF_DIR/oh-my-zshrc
fi

if [ -f $DF_DIR/zsh_functions ]; then
	. $DF_DIR/zsh_functions
fi

# Set defaults.
EDITOR=vim

# Fix tmux clipboard support.
export EVENT_NOKQUEUE=1

# Mouse support in less.
LESS=RS

# Set Vi key bindings.
# bindkey -v
export KEYTIMEOUT=1
# Ctrl-r acts the same as the default emacs bindings.
bindkey '^r' history-incremental-search-backward
# Bind / to incremental search in normal mode.
bindkey -M vicmd '/' history-incremental-search-backward
# Basic emacs style key bindings for insert mode.
bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line
bindkey -M viins '^k' kill-line

# Add script dir to PATH.
export PATH=/usr/local/bin:/usr/local/share/npm/bin:$PATH:$DIR/bin

# Tab completion
autoload -U compinit
compinit

# Tab completion from both ends.
setopt completeinword

# Enable completion cache.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

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
#setopt prompt_subst
#PS1="[%n@%m %c]${vcs_info_msg_0_}$ "

# Misc. options.
setopt auto_cd

if [ -f $DF_DIR/aliases ]; then
	. $DF_DIR/aliases
fi
