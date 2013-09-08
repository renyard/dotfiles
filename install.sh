#!/bin/bash

# Exit on error.
set -e

default_dir=~/dotfiles
repo="https://github.com/renyard/dotfiles.git"
bashrc="~/.bashrc"
vimrc="~/.vimrc"

# Prompt for install location.
read -e -p "Install path: " -i $default_dir df_dir

# Create install location if it doesn't exist.
if [ ! -d $df_dir ]; then
	echo "Creating $df_dir..."
	mkdir -p $df_dir
fi

echo 'Cloning Git Repo...'
git clone $repo $df_dir

cd $df_dir

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

# Add source lines to .bashrc
echo 'Linking .bashrc...'
zshrc="if [ -f $df_dir ]; then . $df_dir/zshrc fi";
if ! grep -Fxq "$zshrc" ~/.zsh; then
	echo $zshrc >> ~/.zshrc
fi

# .bashrc

# Create .bashrc, if required.
if [ ! -e ~/.bashrc ]; then
	echo 'Creating ~/.bashrc...'
	touch ~/.bashrc
fi

# Add source lines to .bashrc
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
