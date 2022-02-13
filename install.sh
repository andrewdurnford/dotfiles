#!/usr/bin/env bash

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

# install zsh plugins
# TODO: clone again to update repos
git clone https://github.com/dracula/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/dracula-zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/dracula/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting-dracula

# homebrew
brew update
brew bundle

DOTFILES=$HOME/code/andrewdurnford/dotfiles

# TODO: symlink bin scripts
# for file in $DOTFILES/bin/*; do ln -sf $DOTFILES/bin/$file /usr/bin/local; done

# symlink git config
ln -sf $DOTFILES/.gitconfig $HOME/.gitconfig

# symlink nvim config
ln -sf $DOTFILES/nvim/init.vim $HOME/.config/nvim/init.vim
ln -sf $DOTFILES/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json

# symlink zsh config
ln -sf $DOTFILES/.zshrc $HOME/.zshrc

# symlink tmux config
ln -sf $DOTFILES/.tmux.conf $HOME/.tmux.conf

# install vim plugins
nvim --headless +PlugInstall +qall

# source macos preferences
source $DOTFILES/.macos

# source tmux config
tmux source $HOME/.tmux.conf
