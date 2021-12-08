set os (uname)

fish_vi_key_bindings
set fish_greeting

starship init fish | source

alias less='less -i'
alias weather='curl http://wttr.in/Boston'
alias exa="exa --header --git --all"
alias python=python3
alias pip=pip3
alias ogvim=/usr/bin/vim
alias vim=nvim
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

if type -q tre
  alias tree=tre
end

if type -q fd
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --color=always'

  if type -q bat
    export FZF_DEFAULT_OPTS='--ansi --preview "bat --color=always {}"'
  else
    export FZF_DEFAULT_OPTS='--ansi'
  end
end

if type -q exa
  alias ls=exa
else
  alias ls='ls -aG --color=auto'
end

if test "$os" = "Darwin"
  alias sudo="sudo -e"
end

export EDITOR=nvim
export SUDO_EDITOR=nvim

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin

if type -q fundle
  fundle plugin 'PatrickF1/fzf.fish'
  fundle plugin 'jethrokuan/z'
end
