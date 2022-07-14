# TODO: update prompt
# prompt
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}
COLOR_DEF=$'\e[0m'
COLOR_USR=$'\e[3;5;243m'
COLOR_DIR=$'\e[38;5;197m'
COLOR_GIT=$'\e[38;5;39m'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} $ '

# fzf
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{.git,node_modules}/*"'
  export FZF_DEFAULT_OPTS='-m --height 50% --border --layout reverse'
  # TODO: filter non-adjacent duplicates
  export FZF_ALT_C_COMMAND='rg --files --hidden -g "!{.git,node_modules}/*" --null | xargs -0 dirname | uniq"'
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
fi

# git
git-commit-amend-widget() {
    # amend commit without changing date
    # see: https://stackoverflow.com/a/61217637
    GIT_COMMITTER_DATE="$(git log -n 1 --format=%aD)" git commit --amend --date="$(git log -n 1 --format=%aD)"
}
zle -N git-commit-amend-widget
alias gca="git-commit-amend-widget"
alias gcd="git-commit-date"
# https://stackoverflow.com/q/1441010
alias gl="git log --pretty=format:\"%h%x09%an%x09%ad%x09%s\""
alias gs="git status"

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
# https://github.com/nvm-sh/nvm#zsh
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
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# tmux
tmux-sessionizer-widget() { 
    tmux-sessionizer 
    zle push-line
    zle reset-prompt 
}
zle -N tmux-sessionizer-widget
bindkey ^n tmux-sessionizer-widget

# remove duplicates from $PATH
typeset -aU path
