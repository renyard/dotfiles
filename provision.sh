#!/usr/bin/env bash

apt-get update -y

# Install PPA dependencies
# apt-get install -y software-properties-common python-software-properties python g++ make

# Add node PPA
# add-apt-repository -y ppa:chris-lea/node.js

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

apt-get update -y

# Install packages
apt-get install -y build-essential cmake git nodejs python python-dev rubygems tmux vim zsh

# Change default shell to zsh.
chsh -s /bin/zsh ubuntu
