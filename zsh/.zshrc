# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Enable autocomplete
autoload -Uz compinit && compinit

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	docker
	fzf
	git
	npm
	nvm
	ripgrep
	tmux
	zsh-autosuggestions
	zsh-syntax-highlighting
)

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# bat
export BAT_THEME="gruvbox-dark"

# fzf
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{.git,node_modules}/*"'
  export FZF_DEFAULT_OPTS='-m --height 50% --border --layout reverse'
  # TODO: filter non-adjacent duplicates
  export FZF_ALT_C_COMMAND='rg --files --hidden -g "!{.git,node_modules}/*" --null | xargs -0 dirname | uniq"'
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
fi

# homebrew
eval $(/opt/homebrew/bin/brew shellenv)
export HOMEBREW_FORCE_BREWED_CURL=1
export HOMEBREW_FORCE_BREWED_GIT=1
export PATH=$HOME/bin:/usr/local/bin:/opt/homebrew/bin:/opt/homebrew/opt/curl/bin:$PATH

# nvim
alias vim="nvim"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm

# tmux
tmux-sessionizer-widget() { 
    tmux-sessionizer 
    zle push-line
    zle reset-prompt 
}
zle -N tmux-sessionizer-widget
bindkey ^n tmux-sessionizer-widget
# if [ -z "$TMUX" ] then tmux attach || tmux fi
# alias exit='if [[ $TMUX = "" ]]; then exit; else tmux detach; fi'

# zsh
fpath+=$(brew --prefix)/share/zsh-completions
autoload -Uz compinit
compinit
source $ZSH/oh-my-zsh.sh

alias gs="git status"

# amend commit without changing date
# see: https://stackoverflow.com/a/61217637
alias gca="GIT_COMMITTER_DATE=\"$(git log -n 1 --format=%aD)\" git commit --amend --date=\"$(git log -n 1 --format=%aD)\""

# remove duplicates from $PATH
typeset -aU path

# run nvm when changing directory
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    # echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
