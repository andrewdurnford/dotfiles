#!/usr/bin/env bash

# Install Oh My Zsh
if [ ! -d "$ZSH" ]; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Install Homebrew
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install VimPlug
if [ ! -f "$HOME/.config/nvim/autoload/plug.vim" ]; then 
  /bin/sh -c 'curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# Update Homebrew packages
brew update

# Install Homebrew packages
brew bundle

# TODO: Update to symlink all scripts in ./bin
# Replaces tmux-sessioniser script with symlink to dotfiles
rm -rf /usr/local/bin/tmux-sessionizer
ln -s $HOME/code/andrewdurnford/dotfiles/bin/tmux-sessionizer /usr/local/bin/tmux-sessionizer

# Replaces .zshrc with symlink to dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/code/andrewdurnford/dotfiles/.zshrc $HOME/.zshrc

# Replaces .gitconfig with symlink to dotfiles
rm -rf $HOME/.gitconfig
ln -s $HOME/code/andrewdurnford/dotfiles/.gitconfig $HOME/.gitconfig

# Replaces .tmux.conf with symlink to dotfiles
rm -rf $HOME/.tmux.conf
ln -s $HOME/code/andrewdurnford/dotfiles/.tmux.conf $HOME/.tmux.conf
tmux source $HOME/.tmux.conf

# Replaces init.vim with symlink to dotfiles
rm -rf $HOME/.config/nvim/init.vim
ln -s $HOME/code/andrewdurnford/dotfiles/nvim/init.vim $HOME/.config/nvim/init.vim

# Replaces :CocConfig with symlink to dotfiles
rm -rf $HOME/.config/nvim/coc-settings.json
ln -s $HOME/code/andrewdurnford/dotfiles/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json

# Install vim plugins
nvim --headless +PlugInstall +qall

# Set macOS preferences
source .macos
