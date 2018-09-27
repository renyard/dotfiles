# If not running interactively, don't do anything.
[[ -z "$PS1" ]] && return

# Get the script path.
DF_DIR="$( cd "$( dirname "$0" )" && pwd )"

# Syntax highlighting config.
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets root)

# Disable auto rename.
export DISABLE_AUTO_TITLE=true

# Source oh my zsh config.
# if [ -f $DF_DIR/oh-my-zshrc ]; then
# 	. $DF_DIR/oh-my-zshrc
# fi

# Source Antigen.
if [ -f $DF_DIR/antigen/bin/antigen.zsh ]; then
	source $DF_DIR/antigen/bin/antigen.zsh
    source $DF_DIR/antigenrc
fi

if [ -f $DF_DIR/zsh_functions ]; then
	source $DF_DIR/zsh_functions
fi

# Set defaults.
EDITOR=vim

# Fix tmux clipboard support.
export EVENT_NOKQUEUE=1

# Mouse support in less.
LESS=RS

# 
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
export PATH=~/bin:$DF_DIR/bin:$DF_DIR/node_modules/.bin:/usr/local/bin:/usr/local/share/npm/bin:$PATH

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
# setopt correctall

# Shared history for all shells.
[ -z "$HISTFILE" ] && HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt incappendhistory 
setopt sharehistory
setopt extendedhistory

# Ignore dupes and commands starting with a space in history.
setopt histignorealldups
setopt histignorespace

# Display CPU usage for commands taking longer than 10 seconds.
export REPORTTIME=10

# FZF
# export FZF_DEFAULT_OPTS='--preview'
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [ -x "$(command -v node)" ]; then
    export NVM_DIR="${DF_DIR}/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

    # Automatically call nvm use
    autoload -U add-zsh-hook
    load-nvmrc() {
      local node_version="$(nvm version)"
      local nvmrc_path="$(nvm_find_nvmrc)"

      if [ -n "$nvmrc_path" ]; then
        local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

        if [ "$nvmrc_node_version" = "N/A" ]; then
          nvm install
        elif [ "$nvmrc_node_version" != "$node_version" ]; then
          nvm use
        fi
      elif [ "$node_version" != "$(nvm version default)" ]; then
        echo "Reverting to nvm default version"
        nvm use default
      fi
    }
    add-zsh-hook chpwd load-nvmrc
    load-nvmrc
fi

# VCS info.
# if function_exists vcs_info; then
# 	autoload -Uz vcs_info
# 	zstyle ':vcs_info:*' enable git svn

# 	precmd() {
# 		vcs_info 'prompt'
# 	}
# fi

# Custom prompt.
#setopt prompt_subst
#PS1="[%n@%m %c]${vcs_info_msg_0_}$ "

# Misc. options.
setopt auto_cd

if [ -f $DF_DIR/aliases ]; then
	. $DF_DIR/aliases
fi
