# TODO: update prompt
# prompt
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}
# COLOR_DEF=$'\e[0m'
# COLOR_USR=$'\e[3;5;243m'
# COLOR_DIR=$'\e[38;5;197m'
# COLOR_GIT=$'\e[38;5;39m'
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
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
  nvm $@
}

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

# auto lazy-load nvm
#
# https://blog.yo1.dog/better-nvm-lazy-loading
#
# Does not work with internal aliases `node`, `stable`, `unstable`, `iojs`
# TODO: add a fallback to call nvm when these are encountered
autoload -U add-zsh-hook
lazy-load-nvmrc() {
  # TODO: fix broken syntax highlighting caused by `2>/dev/null` inside var
  # Get the nvm version in order of local .nvmrc, global .nvmrc, global default
  NODE_VER="$((cat .nvmrc || cat ~/.nvmrc || cat "$NVM_DIR/alias/default") 2>/dev/null )"

  if [ -s .nvmrc ]; then
    echo "Found '$(pwd)/.nvmrc' with version <$NODE_VER>"
  fi
  
  # Recursively resolve the aliases
  while [ -s "$NVM_DIR/alias/$NODE_VER" ] && [ ! -z "$NODE_VER" ]; do
    NODE_VER="$(cat "$NVM_DIR/alias/$NODE_VER")"
  done

  # Resolve the path 
  NODE_VER_PATH="$(find $NVM_DIR/versions/node -maxdepth 1 -name "v${NODE_VER#v}*" | sort -rV | head -n 1)"

  # Add the node version to path
  if [ ! -z "$NODE_VER_PATH" ]; then
    export PATH="$NODE_VER_PATH/bin:$PATH"

    if [ -s .nvmrc ]; then
      echo "Now using node $(node -v) (npm v$(npm -v))"
    fi
  fi

  # remove duplicates from $PATH
  typeset -aU path
}

add-zsh-hook chpwd lazy-load-nvmrc
lazy-load-nvmrc
