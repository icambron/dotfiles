# VARS
set fish_greeting
set fish_cursor_unknown block

# BASICS
fish_vi_key_bindings

# PROMPT
if type -q starship
    starship init fish | source
end

# PATHS
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/code/lqbk/LBDeploy/src/main/python
fish_add_path $HOME/code/lbt
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/ruby/bin
fish_add_path (ruby -e 'puts Gem.dir')/bin
fish_add_path /Users/isaac/.local/bin

# OTHER ENV
export EDITOR=nvim
export SUDO_EDITOR=nvim
export GRIM_DEFAULT_DIR=$HOME/screenshots
export GPG_TTY=(tty)
export LB_HOME=$HOME/code/lqbk

if test -e ~/.private_fish
    source ~/.private_fish
end

# ALIASES
alias less='less -i'
alias weather='curl http://wttr.in/lexington+ma'
alias python=python3
alias pip=pip3
alias python=python3
alias pip=pip3
alias ogvim=/usr/bin/vim
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias z=zoxide
alias zel=zellij
alias slark=ssh slark

alias lbme="lbt logs less logic-devb52"

if type -q nvim
    alias vim=nvim
end

if type -q tre
    alias tree=tre
end

if type -q exa
    alias lss=/bin/ls
    alias ls=exa
    alias exa="exa --header --git --all"
else
    alias ls='ls -aG --color=auto'
end

if test (uname) = Darwin
    alias sudoedit="sudo -e"
end

# FZF
if type -q fd
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --color=always'
end

if type -q bat
    export FZF_DEFAULT_OPTS='--ansi --preview "bat --color=always {}"'
else
    export FZF_DEFAULT_OPTS='--ansi'
end

# FUNCTIONS

# scan a doc like `scan foo.pdf`
function scan
    set temp (mktemp)
    scanimage --device "airscan:w2:Brother ADS-2700W [000ec6eba5ad]" --format=pnm --output-file "$temp"
    gm convert $temp $argv
end

# open vi with an fzf autocomplete
function fvi
    vim (fzf)
end
