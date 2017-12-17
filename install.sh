#!/bin/bash

# Exit on error.
set -e

if [ -z "${DOTFILES}" ]; then
    df_dir="~/dotfiles"
else
    df_dir="${DOTFILES}"
fi

bashrc="${HOME}/.bashrc"
zshrc="${HOME}/.zshrc"
vimrc="${HOME}/.vimrc"
tmuxconf="${HOME}/.tmux.conf"
bash_re="/bash$/"
zsh_re="/zsh$/"

echo 'Initializing Submodules...'
git submodule init

echo 'Updating Submodules...'
git submodule update

# Update .*rc files.

# .zshrc

# Create .zshrc if required.
if [ ! -e $zshrc ]; then
	echo 'Creating ~/.zshrc...'
	touch $zshrc
fi

# Add source lines to .zshrc.
echo 'Linking .zshrc...'
zshrc_line="[ -d $df_dir ] && . $df_dir/zshrc";
if ! grep -Fxq "$zshrc_line" $zshrc; then
	echo $zshrc_line >> $zshrc
fi

# .bashrc

# Create .bashrc, if required.
if [ ! -e $bashrc ]; then
	echo 'Creating ~/.bashrc...'
	touch $bashrc
fi

# Add source lines to .bashrc.
echo 'Linking .bashrc...'
bashrc_line="[ -d $df_dir ] && . $df_dir/bashrc";
if ! grep -Fxq "$bashrc_line" $bashrc; then
	echo $bashrc_line >> $bashrc
fi

# .vimrc

# Create .vimrc, if required.
if [ ! -e $vimrc ]; then
	echo 'Creating ~/.vimrc...'
	touch $vimrc
fi

# Add source lines to .vimrc.
echo 'Linking .vimrc...'
vimrc_line="source $df_dir/vimrc"
if ! grep -Fxq "$vimrc_line" $vimrc; then
	echo $vimrc_line >> $vimrc
fi

# .tmux.conf

# Create .tmux.conf, if required.
if [ ! -e $tmuxconf ]; then
	echo 'Creating ~/.tmux.conf...'
	touch $tmuxconf
fi

# Add source lines to .tmux.conf.
echo 'Linking .tmux.conf...'
tmuxconf_line="source $df_dir/tmux.conf"
if ! grep -Fxq "$tmuxconf_line" $tmuxconf; then
	echo $tmuxconf_line >> $tmuxconf
fi

# # Create ~/.config directory.
# if [ ! -d ~/.config ]; then
#     mkdir -p ~/.config
# fi

# # Link neovim directory to vim's.
# if [ ! -L ~/.config/nvim ]; then
#     ln -s ~/.vim ~/.config/nvim
# fi

# # Link neovim init.vim to .vimrc.
# if [ ! -L ~/.config/nvim/init.vim ]; then
#     ln -s ~/.vimrc ~/.config/nvim/init.vim
# fi

# Source shell config.
if [[ $SHELL =~ "$bash_re" ]]; then
	source $bashrc
elif [[ $SHELL =~ "$zsh_re" ]]; then
	source $zshrc
fi

# Create .tern-config symlink.
if [ ! -L ~/.tern-config ]; then
    ln -s $df_dir/tern-config ~/.tern-config
fi

# Install Vim plugins.
echo "Installing Vim plugins..."
# vim -u plugins.vim +nocompatible +PlugInstall +qall > /dev/null
vim -Nu plugins.vim +PlugInstall +qall

# Install tmux plugins.
cd $df_dir/tmux/plugins/tpm/bin/
./install_plugins
