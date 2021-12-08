os=$(uname)

# Vi mode
bindkey -v

# 10ms for key sequences
KEYTIMEOUT=1

# completions
fpath=(/usr/local/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# v to open command in vim
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

setopt NO_BEEP

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

#aliases
if [[ "$os" == 'Darwin' ]]; then
  alias sudoedit="sudo -e"
fi

alias less='less -i'
alias python=python3
alias pip=pip3
alias ls='ls -aG --color=auto'
alias ogvim=/usr/bin/vim
alias vim=nvim
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# path
export PATH=~/.cargo/bin:$PATH
export PATH="$PATH:$HOME/.local/bin"

# editors
export EDITOR=nvim
export SUDO_EDITOR=nvim
