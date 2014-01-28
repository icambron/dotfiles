export PATH=/usr/local/bin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/opt/X11/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:/usr/local/share/python
export PATH=$PATH:/usr/local/tranquil/bin
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$PATH:/usr/local/mysql/bin
export PATH=$PATH:$HOME/code/go/bin

export GOPATH=$HOME/code/go

if [ -e ~/.nvm ]; then
  ~/.nvm/nvm.sh
fi

export EDITOR=vim

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
  export JAVA_HOME=$(/usr/libexec/java_home -v '1.7*')
fi

[[ -s "$HOME/.zshprivate" ]] && source "$HOME/.zshprivate"
