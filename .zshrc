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

# don't complain when leaving jobs behind
setopt nohup
setopt nocheckjobs

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
export EDITOR=vim

#other aliases
alias nr=repl.history
alias less='less -i'

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

#chruby
source /usr/local/share/chruby/chruby.sh
chruby ruby-2.1

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

export PATH=/usr/local/bin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/opt/X11/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:/usr/local/share/python
export PATH=$PATH:/usr/local/tranquil/bin
export PATH=$PATH:/usr/local/mysql/bin
export PATH=$PATH:/usr/local/heroku/bin
export PATH=$PATH:$HOME/code/go/bin
export GOPATH=$HOME/code/go

if [ -e ~/.nvm ]; then
  ~/.nvm/nvm.sh
fi


#OS-specific stuff
os=$(uname)
home='unknown'
if [[ "$os" == 'Linux' ]]; then
  home='/home'
  if [[ $(uname -m) == 'x86_64' ]]; then
    #export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64
  else
    #export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-i386
  fi
elif [[ "$os" == 'Darwin' ]]; then
  PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
  home='/Users'
  export JAVA_HOME=$(/usr/libexec/java_home -v '1.7*')
fi

[[ -s "$HOME/.zshprivate" ]] && source "$HOME/.zshprivate"
