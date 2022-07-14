# dotfiles

```
.
├── bin
│   └── usr
│       └── local
│           └── bin
│               ├── git-commit-date
│               ├── tmux-sessionizer
│               └── tmux-windowizer
├── git
│   ├── .gitconfig
│   └── .gitignore
├── iterm2
│   └── com.googlecode.iterm2.plist
├── macos
│   ├── .macos
│   └── README.md
├── nvim
│   └── .config
│       └── nvim
│           ├── lua
│           │   └── user
│           │       ├── autopairs.lua
│           │       ├── colorizer.lua
│           │       ├── gitsigns.lua
│           │       ├── lsp-config.lua
│           │       ├── lualine.lua
│           │       ├── onedark.lua
│           │       ├── telescope.lua
│           │       └── treesitter.lua
│           └── init.vim
├── tmux
│   └── .tmux.conf
├── zsh
│   └── .zshrc
├── .gitignore
├── Brewfile
├── LICENSE
└── README.md
```

## Installation

1. Update macOS to the latest version with the App Store

2. Install rosetta

```bash
softwareupdate --install-rosetta --agree-to-license
```

3. Install xcode

```bash
xcode-select --install
```

4. Install homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

5. [Generate new SSH key](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

```bash
# Generate a new SSH key
ssh-keygen -t ed25519 -C "andrewdurnford3@gmail.com" -f ~/.ssh/id_ed25519

# Enter passphrase

# Add SSH key to the ssh-agent
eval "$(ssh-agent -s)"
touch ~/.ssh/config
echo "Host *\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ~/.ssh/id_ed25519" | tee ~/.ssh/config
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Add SSH key to github account
# https://github.com/settings/keys
pbcopy < ~/.ssh/id_ed25519.pub
```

5. Clone this repository to `~/code/andrewdurnford/dotfiles`

```bash
git clone git@github.com:andrewdurnford/dotfiles.git
```

6. Install homebrew packages

```bash
brew update
brew upgrade
brew bundle
```

7. Symlink config files

```bash
# TODO: move to ~/.local/bin and add to zsh path
# symlink bin scripts
sudo stow -t / bin

# TODO: https://github.com/aspiers/stow/issues/75
# symlink git, nvim, tmux, zsh
stow -t ~ git nvim tmux zsh
```

8. Setup neovim

```bash
# Install VimPlug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install plugins
nvim --headless +PlugInstall +qall

# Install language servers
nvim --headless :LspInstall +qall
```

9. Customise system preferences

See [macOS README](./macos/README.md)

10. Restart to finalise the process
