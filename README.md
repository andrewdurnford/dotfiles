# dotfiles

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

```
Dock & Menu Bar > Battery
- `enable` "Show in Menu Bar"
- `enable` "Show Percentage"

Dock & Menu Bar > Now Playing
- `enable` "Show in Menu Bar" "Always"

Siri
- `disable` "Enable Ask Siri"

Security & Privacy > General
- Allow apps downloaded from "App Store and identified developers"

Security & Privacy > Firewall
- `enable` "Turn On Firewall"

Sound > Sound Effects
- `enable` "Show volume in menu bar"

Keyboard > Keyboard
- Touchbar Shows "Expanded Control Strip"
- `remap` Modifier Keys "Caps Lock" to "Control"

Keyboard > Shortcuts
- Move left / right a space "^ + <-" / "^ + ->"
- Switch to Desktop 1-0 "^ + 1-0"

Trackpad > Point & Click
- `disable` "Force Click and haptic feedback"

Trackpad > More Gestures
- `enable` "App Exposé"

Displays
- `disable` "True Tone"

Sharing
- `disable` "File Sharing"
```

8. Restart to finalise the process
