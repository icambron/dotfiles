os=$(uname)
TERM=xterm-256color

# completions
fpath=(/usr/local/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit

#source "$HOME/.prompt.zsh"
eval "$(starship init zsh)"
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
alias ls='ls -aG'

# Vi mode
bindkey -v

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# 10ms for key sequences
KEYTIMEOUT=1

export LSCOLORS="Gxfxcxdxbxegedabagacad"
export FZF_DEFAULT_COMMAND='fd --type f'

export SPARK_HOME=/usr/local/spark
export NUGET_CONFIG_PATH=~/.nuget/NuGet/Nuget.Config
export PATH=$PATH:$SPARK_HOME/bin
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="$PATH:/Users/isaaccambron/.dotnet/tools"
export JAVA_HOME=$(/usr/libexec/java_home -v14)

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

fdiff() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview $preview
}

pack () {
	dotnet pack -c Release -o ./packages -p:PackageVersion="$1"
}

add () {
	for nupkg in packages/*.nupkg
	do
		nuget add "$nupkg" -source /Users/isaaccambron/.nuget/custom-local-packages
	done
}

