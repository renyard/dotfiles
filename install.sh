#!/bin/bash

# Exit on error.
set -e

default_dir=~/dotfiles
repo="https://github.com/renyard/dotfiles.git"
bashrc="~/.bashrc"
vimrc="~/.vimrc"

# Prompt for install location.
read -e -p "Install path: " -i $default_dir dt_dir

# Create install location if it doesn't exist.
if [ ! -d $dt_dir ]; then
	echo "Creating $dt_dir..."
	mkdir -p $dt_dir
fi

echo 'Cloning Git Repo...'
git clone $repo $dt_dir

cd $dt_dir

echo 'Initializing Submodules...'
git submodule init

echo 'Updating Submodules...'
git submodule update

# Update .*rc files.

# .bashrc

# Create .bashrc, if required.
if [ ! -e ~/.bashrc ]; then
	echo 'Creating ~/.bashrc...'
	touch ~/.bashrc
fi

# Add source lines to .bashrc
echo 'Linking .bashrc...'
bashrc="if [ -f $dt_dir ]; then . $dt_dir/bashrc fi";
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
vimrc="source $dt_dir/vimrc"
if ! grep -Fxq "$vimrc" ~/.vimrc; then
	echo $vimrc >> ~/.vimrc
fi
