fish_vi_key_bindings
set fish_greeting

starship init fish | source

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

export FZF_DEFAULT_COMMAND='fd --type f -H'
export EDITOR=nvim
export SUDO_EDITOR=nvim

fish_add_path /home/isaac/.cargo/bin
fish_add_path /home/icambron/.local/bin

