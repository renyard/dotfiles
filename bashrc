# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Get the script path.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load aliases.
if [ -f $DIR/aliases ]; then
	source $DIR/aliases
fi

# Add script dir to PATH.
export PATH=/usr/local/bin:/usr/local/share/npm/bin:$PATH:$DIR/bin

# Set defaults.
PS1='[\u@\h \W]\$ '
EDITOR=/usr/bin/vim

# Set completion options.
set completion-ignore-case on
set visible-stats on

# Append history on each command, rather than when the shell exits.
shopt -s histappend
PROMT_COMMAND='history -a'

# Disable history for commands prepended with a space and exit command.
export HISTIGNORE="&:[ ]*:exit"
