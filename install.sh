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

# symlink bin scripts
for file in $DOTFILES/bin/*; do sudo ln -sf $file /usr/local/bin; done

# symlink git config
ln -sf $DOTFILES/git/.gitconfig $HOME/.gitconfig
ln -sf $DOTFILES/git/.gitignore $HOME/.gitignore

# symlink macos config
ln -sf $DOTFILES/macos/.macos $HOME/.macos

# symlink nvim config
ln -sf $DOTFILES/nvim/init.vim $HOME/.config/nvim/init.vim
ln -sf $DOTFILES/nvim/lua/user $HOME/config/nvim/lua/user

# symlink zsh config
ln -sf $DOTFILES/zsh/.zshrc $HOME/.zshrc
source $HOME/.zshrc

# symlink tmux config
ln -sf $DOTFILES/tmux/.tmux.conf $HOME/.tmux.conf
tmux source $HOME/.tmux.conf

# install node via nvm
nvm install --lts

# install vim plugins
nvim --headless +PlugInstall +qall

source $HOME/.macos
source $HOME/.zshrc

