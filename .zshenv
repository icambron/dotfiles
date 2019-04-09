export PATH=$HOME/bin:$PATH
export PATH=$PATH:/opt/X11/bin
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:/usr/local/tranquil/bin
export PATH=$PATH:/usr/local/heroku/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/code/go/bin

export GOPATH=$HOME/code/go

[[ -s "$HOME/.zshprivate" ]] && source "$HOME/.zshprivate"
[[ -s "$HOME/.zshgpg" ]] && source "$HOME/.zshgpg"

export EDITOR=vim

export LSCOLORS="Gxfxcxdxbxegedabagacad"

function path_remove {
  # Delete path by parts so we can never accidentally remove sub paths
  PATH=${PATH//":$1:"/":"} # delete any instances in the middle
  PATH=${PATH/#"$1:"/} # delete any instance at the beginning
  PATH=${PATH/%":$1"/} # delete any instance in the at the end
}

path_remove '/mnt/c/Program Files/nodejs/npm'
path_remove '/mnt/c/Python37'

# why is this so slow?
test -e keychain && eval `keychain --quiet --eval --agents ssh id_rsa`

# todo - should only be in WSL

if [[ "$(< /proc/version)" == *@(Microsoft|WSL)* ]]; then
  export DOCKER_HOST=tcp://0.0.0.0:2375
fi
