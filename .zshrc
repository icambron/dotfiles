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

export LSCOLORS="Gxfxcxdxbxegedabagacad"
export FZF_DEFAULT_COMMAND='fd --type f -H'

export NUGET_CONFIG_PATH=~/.nuget/NuGet/Nuget.Config
export PATH=$PATH:$SPARK_HOME/bin
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH=/usr/local/lib/ruby/gems/3.0.0/bin:$PATH
export PATH=~/.cargo/bin:$PATH

if type /usr/libexec/java_home > /dev/null; then
  export JAVA_HOME=$(/usr/libexec/java_home -v16)
fi

export PATH="$PATH:/home/icambron/.local/bin"

export EDITOR=nvim
export SUDO_EDITOR=nvim

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

fdiff() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview $preview
}

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
#   exec sway
# fi
#
