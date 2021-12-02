os=$(uname)

# completions
fpath=(/usr/local/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit

if command -v starship > /dev/null; then
  eval "$(starship init zsh)"
fi

[[ -s "$HOME/.zshprivate" ]] && source "$HOME/.zshprivate"

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
alias ack=ag
alias weather='curl http://wttr.in/Boston'
alias emacs='emacs -nw'
alias exa="exa --header --long --git --all"
alias python=python3
alias pip=pip3
alias ls='ls -aG --color=auto'
alias ogvim=/usr/bin/vim
alias vim=nvim
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Vi mode
bindkey -v

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# 10ms for key sequences
KEYTIMEOUT=1

export FZF_DEFAULT_COMMAND='fd --type f -H'
export PATH=~/.cargo/bin:$PATH

if type /usr/libexec/java_home > /dev/null; then
  export JAVA_HOME=$(/usr/libexec/java_home -v16)
fi

export PATH="$PATH:/home/icambron/.local/bin"

export EDITOR=nvim
export SUDO_EDITOR=nvim

autoload -U +X bashcompinit && bashcompinit
