# VARS
set fish_greeting

# BASICS
fish_vi_key_bindings

# PROMPT
if type -q starship
  starship init fish | source
end

# PATHS
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin

# OTHER ENV
export EDITOR=nvim
export SUDO_EDITOR=nvim

# ALIASES
alias less='less -i'
alias weather='curl http://wttr.in/Boston'
alias exa="exa --header --git --all"
alias python=python3
alias pip=pip3
alias ogvim=/usr/bin/vim
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

if type -q nvim
  alias vim=nvim
end

if type -q tre
  alias tree=tre
end

if type -q exa
  alias ls=exa
else
  alias ls='ls -aG --color=auto'
end

if test (uname) = "Darwin"
  alias sudoedit="sudo -e"
end

# PLUGINS
if type -q fundle
  fundle plugin 'PatrickF1/fzf.fish'
  fundle plugin 'jethrokuan/z'
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
