#!/usr/bin/env bash

# Install Oh My Zsh
if [ ! -d "$ZSH" ]; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Install Homebrew
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew packages
brew update

# Install Homebrew packages
brew bundle

# Replaces .zshrc with symlink to dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/code/andrewdurnford/dotfiles/.zshrc $HOME/.zshrc

# Add .gitconfig with symlink to dotfiles
rm -rf $HOME/.gitconfig
ln -s $HOME/code/andrewdurnford/dotfiles/.gitconfig $HOME/.gitconfig

# Set macOS preferences
source .macos
