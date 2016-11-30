#!/bin/bash

# Exit on error.
set -e

df_dir="~/dotfiles"
bashrc="~/.bashrc"
vimrc="~/.vimrc"
bash_re="/bash$/"
zsh_re="/zsh$/"

echo 'Initializing Submodules...'
git submodule init

echo 'Updating Submodules...'
git submodule update

# Update .*rc files.

# .zshrc

# Create .zshrc if required.
if [ ! -e ~/.zshrc ]; then
	echo 'Creating ~/.zshrc...'
	touch ~/.zshrc
fi

# Add source lines to .zshrc.
echo 'Linking .zshrc...'
zshrc="[ -d $df_dir ] && . $df_dir/zshrc";
if ! grep -Fxq "$zshrc" ~/.zshrc; then
	echo $zshrc >> ~/.zshrc
fi

# .bashrc

# Create .bashrc, if required.
if [ ! -e ~/.bashrc ]; then
	echo 'Creating ~/.bashrc...'
	touch ~/.bashrc
fi

# Add source lines to .bashrc.
echo 'Linking .bashrc...'
bashrc="[ -d $df_dir ] && . $df_dir/bashrc";
if ! grep -Fxq "$bashrc" ~/.bashrc; then
	echo $bashrc >> ~/.bashrc
fi

# .vimrc

# Create .vimrc, if required.
if [ ! -e ~/.vimrc ]; then
	echo 'Creating ~/.vimrc...'
	touch ~/.vimrc
fi

# Add source lines to .vimrc.
echo 'Linking .vimrc...'
vimrc="source $df_dir/vimrc"
if ! grep -Fxq "$vimrc" ~/.vimrc; then
	echo $vimrc >> ~/.vimrc
fi

# Source shell config.
if [[ $SHELL =~ "$bash_re" ]]; then
	source ~/.bashrc
elif [[ $SHELL =~ "$zsh_re" ]]; then
	source ~/.zshrc
fi

# Create .tern-config symlink.
if [ ! -e ~/.tern-config ]; then
    ln -s $df_dir/tern-config ~/.tern-config
fi

# Install Vim plugins.
echo "Installing Vim plugins..."
MYVIMRC=$df_dir/plugins.vim vim +PluginInstall +qall > /dev/null

# Install tmux plugins.
cd $df_dir/tmux/plugins/tpm/bin/
./install_plugins
