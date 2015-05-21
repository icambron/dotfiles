TERM=xterm-256color

source "$HOME/.prompt.zsh"

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
unsetopt share_history # share command history data between instances

os=$(uname)
if [[ "$os" == 'Darwin' ]]; then
  alias sudoedit="sudo -e"
fi

export EDITOR=vim

#ls
alias ls='ls -aG'
export LSCOLORS="Gxfxcxdxbxegedabagacad"

#git shortcuts
alias rupstream=git pull upstream --rebase master
alias rorigin=git pull origin --rebase master

#other aliases
alias nr=repl.history
alias less='less -i'
  alias ack=ag

csv() { csvtool readable $@ | view -}

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# 10ms for key sequences
KEYTIMEOUT=1
