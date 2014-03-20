autoload -U colors && colors
setopt PROMPT_SUBST

GIT_PROMPT_PREFIX="$fg[green]["
GIT_PROMPT_SUFFIX="]$reset_color"

# get the name of the branch we are on
function git_prompt_info() {
  local DIRTY_OR_CLEAN=''
  local GIT_STATUS=''

  GIT_STATUS=$(command git status -s --ignore-submodules=dirty 2> /dev/null | tail -n1)

  if [[ -n $GIT_STATUS ]]; then
    DIRTY_OR_CLEAN=" $fg[red]*$fg[green]"
  fi

  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "$GIT_PROMPT_PREFIX${ref#refs/heads/}$DIRTY_OR_CLEAN$GIT_PROMPT_SUFFIX"
}

PROMPT=$'%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%I:%M:%S]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info)\
%{$fg[blue]%}->%{$fg_bold[blue]%} %{$reset_color%}'

# vi mode
bindkey -v

# autocomplete
unsetopt menu_complete   # do not autoselect the first completion entry
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

# history
if [ -z $HISTFILE ]; then
  HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
unsetopt share_history # share command history data

os=$(uname)
if [[ "$os" == 'Linux' ]]; then
  alias ack=ack-grep
elif [[ "$os" == 'Darwin' ]]; then
  alias sudoedit="sudo -e"
fi

#ls
alias ls='ls -G'
export LSCOLORS="Gxfxcxdxbxegedabagacad"

#other aliases
alias nr=repl.history
alias less='less -i'

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

#chruby
source /usr/local/share/chruby/chruby.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# added by travis gem
[ -f /Users/isaac/.travis/travis.sh ] && source /Users/isaac/.travis/travis.sh

