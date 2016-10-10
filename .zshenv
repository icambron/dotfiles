export PATH=/usr/local/bin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/opt/X11/bin
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:/usr/local/tranquil/bin
export PATH=$PATH:/usr/local/heroku/bin
export PATH=$PATH:$HOME/code/go/bin
export GOPATH=$HOME/code/go

export ZS_HOME=/Users/isaac/code/zensight

[[ -s "$HOME/.zshprivate" ]] && source "$HOME/.zshprivate"
[[ -s "$HOME/.zshgpg" ]] && source "$HOME/.zshgpg"

export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="/Users/isaac/.docker/machine/machines/zensight"
export DOCKER_MACHINE_NAME="zensight"

export EDITOR=vim

export LSCOLORS="Gxfxcxdxbxegedabagacad"
