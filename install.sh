#!/usr/bin/env zsh

# install homebrew
if test ! $(which brew); then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install omz
if [ ! -d "$ZSH" ]; then
	/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# install vimplug
if [ ! -f "$HOME/.config/nvim/autoload/plug.vim" ]; then
	/bin/sh -c 'curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# suppress zsh-completion homebrew warning
chmod -R go-w /opt/homebrew/share

# homebrew
brew update
brew bundle

DOTFILES=$HOME/code/andrewdurnford/dotfiles

# TODO: move to ~/.local/bin and add to zsh path
# symlink bin scripts
sudo stow -t / bin

# TODO: https://github.com/aspiers/stow/issues/75
# symlink git, nvim, tmux, zsh, yabai, skhd
stow -t ~ git nvim tmux zsh yabai skhd

# install node via nvm
nvm install --lts

# install vim plugins
nvim --headless +PlugInstall +qall

source $HOME/.macos
source $HOME/.zshrc

