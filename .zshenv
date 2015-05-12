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

if [ -e ~/.nvm ]; then
  ~/.nvm/nvm.sh
fi

#OS-specific stuff
os=$(uname)
home='unknown'
if [[ "$os" == 'Linux' ]]; then
  home='/home'
  if [[ $(uname -m) == 'x86_64' ]]; then
    #export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64
  else
    #export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-i386
  fi
elif [[ "$os" == 'Darwin' ]]; then
  PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
  home='/Users'
  if [ -e /usr/libexec/java_home ]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v '1.8*')
  fi
fi

#chruby
if [ -e /usr/local/share/chruby/chruby.sh ]; then
  source /usr/local/share/chruby/chruby.sh
  chruby ruby-2.1.5
fi

[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

[[ -s "$HOME/.zshprivate" ]] && source "$HOME/.zshprivate"

if [ -e /usr/local/share/zsh/site-functions/_aws ]; then
  source /usr/local/share/zsh/site-functions/_aws
fi

if [ -e /usr/local/bin/boot2docker ]; then 
  $(boot2docker shellinit 2>/dev/null)
fi
