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
export BAT_THEME="Dracula"

# curl
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# fzf
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{.git,node_modules}/*"'
  export FZF_DEFAULT_OPTS='-m --height 50% --border --layout reverse'
  # TODO: filter non-adjacent duplicates
  export FZF_ALT_C_COMMAND='rg --files --hidden -g "!{.git,node_modules}/*" --null | xargs -0 dirname | uniq"'
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
fi

# homebrew
export PATH=$HOME/bin:/usr/local/bin:/opt/homebrew/bin:$PATH

# nvim
alias vim="nvim"

# nvm
export NVM_DIR="~/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# tmux
tmux-sessionizer-widget() { 
    tmux-sessionizer 
    zle push-line
    zle reset-prompt 
}
zle -N tmux-sessionizer-widget
bindkey ^f tmux-sessionizer-widget
# if [ -z "$TMUX" ] then tmux attach || tmux fi
# alias exit='if [[ $TMUX = "" ]]; then exit; else tmux detach; fi'

# zsh
fpath+=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions/src
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/dracula-zsh-syntax-highlighting/zsh-syntax-highlighting.sh
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/oh-my-zsh.sh

# misc
# npmrc() { cp ~/.npmrc . }