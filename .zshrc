# VARS
os=$(uname)
fpath=(/usr/local/share/zsh/site-functions $fpath)
KEYTIMEOUT=1
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history

# OPTS
setopt NO_BEEP
setopt nohup
setopt nocheckjobs
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
unsetopt share_history

# CAPABILITIES
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit
autoload edit-command-line
zle -N edit-command-line

# KEYS
bindkey -v
bindkey -M vicmd v edit-command-line

# ALIASES
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

# PATH
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/bin"

# OTHER ENV
export EDITOR=nvim
export SUDO_EDITOR=nvim
