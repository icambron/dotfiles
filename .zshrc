TERM=xterm-256color

source "$HOME/.prompt.zsh"

# jesus fucking christ
setopt NO_BEEP

# vi mode
bindkey -v
bindkey "^R" history-incremental-search-backward

# autocomplete
unsetopt menu_complete   # do not autoselect the first completion entry
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end


# this is some task background thing that doesn't work in WSL
unsetopt BG_NICE

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

#ls
alias ls='ls -aG'

#git shortcuts
alias rupstream=git pull --rebase upstream master
alias rorigin=git pull --rebase origin master

#other aliases
alias less='less -i'
alias ack=ag
alias fig=docker-compose
alias weather='curl http://wttr.in/Boston'
alias emacs='emacs -nw'
alias python=/usr/bin/python3
alias pip=/usr/bin/pip3

csv() { csvtool readable $@ | view -}

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# 10ms for key sequences
KEYTIMEOUT=1

#initialize completion
autoload -Uz compinit && compinit

#these can't go in zhenv because /etc/paths will supersede them
export PATH=$HOME/anaconda2/bin:$PATH

[ -s "${HOME}/.iterm2_shell_integration.zsh" ] && source "${HOME}/.iterm2_shell_integration.zsh"

[[ -z "$TMUX" && -n "$USE_TMUX" ]] && {
    [[ -n "$ATTACH_ONLY" ]] && {
        tmux a 2>/dev/null || {
            cd && exec tmux
        }
        exit
    }

    tmux new-window -c "$PWD" 2>/dev/null && exec tmux a
    exec tmux
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -s "/usr/local/share/chruby/chruby.sh" ] && source "/usr/local/share/chruby/chruby.sh" && chruby ruby-2.6
