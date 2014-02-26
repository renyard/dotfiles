#!/bin/bash

# Exit on error.
set -e

script=$(readlink -f $0)
df_dir=$(dirname "$script")
bashrc="~/.bashrc"
vimrc="~/.vimrc"

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
zshrc="if [ -f $df_dir ]; then . $df_dir/zshrc fi";
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
bashrc="if [ -f $df_dir ]; then . $df_dir/bashrc fi";
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
