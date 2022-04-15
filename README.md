# dotfiles

```
.
├── bin
│   ├── git-commit-date
│   ├── tmux-sessionizer
│   └── tmux-windowizer
├── git
│   ├── .gitconfig
│   └── .gitignore
├── iterm2
│   └── com.googlecode.iterm2.plist
├── macos
│   ├── .macos
│   └── README.md
├── nvim
│   ├── lua
│   │   └── user
│   │       ├── autopairs.lua
│   │       ├── colorizer.lua
│   │       ├── gitsigns.lua
│   │       ├── lsp-config.lua
│   │       ├── lualine.lua
│   │       ├── onedark.lua
│   │       ├── telescope.lua
│   │       └── treesitter.lua
│   └── init.vim
├── tmux
│   └── .tmux.conf
├── zsh
│   └── .zshrc
├── .gitignore
├── Brewfile
├── LICENSE
├── README.md
└── install.sh
```

## Installation

1. Update macOS to the latest version with the App Store
2. Install rosetta (m1 mac)

```bash
softwareupdate --install-rosetta --agree-to-license
```

3. Install xcode

```bash
xcode-select install
```

4. [Generate new SSH key](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

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

5. Clone this repository

```bash
git clone git@github.com:andrewdurnford/dotfiles.git
```

6. Run the install script

```bash
cd dotfiles
./install.sh
```

7. Customise system preferences

See [macOS README](./macos/README.md)

8. Restart to finalise the process
