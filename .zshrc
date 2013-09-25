# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="candy"

CASE_SENSITIVE="true"

EXTENDED_HISTORY= "true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

#make the git file finder not actually use git
__git_files () {
  _wanted files expl 'local files' _files
}

source $ZSH/oh-my-zsh.sh

#override some of the oh-my-zsh stuff
unsetopt append_history
unsetopt inc_append_history
unsetopt share_history

os=$(uname)
if [[ "$os" == 'Linux' ]]; then
  alias ack=ack-grep
elif [[ "$os" == 'Darwin' ]]; then
  alias sudoedit="sudo -e"
fi

#aliases
alias ls='ls -G'
alias tree='nocorrect tree'
alias nr=repl.history
alias less='less -i'
