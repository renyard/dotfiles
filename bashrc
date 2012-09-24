# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Get the script path.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load aliases.
if [ -f $DIR/aliases ]; then
	source $DIR/aliases
fi

# Set defaults.
PS1='[\u@\h \W]\$ '
EDITOR=/usr/bin/vim

# Disable history for commands prepended with a space and exit command.
export HISTIGNORE="&:[ ]*:exit"
