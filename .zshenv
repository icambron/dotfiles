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

[[ -s "$HOME/.zshprivate" ]] && source "$HOME/.zshprivate"
[[ -s "$HOME/.zshgpg" ]] && source "$HOME/.zshgpg"

#these never change anymore
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/isaac/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
