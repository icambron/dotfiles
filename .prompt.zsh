#! /bin/zsh

autoload -U colors && colors
setopt PROMPT_SUBST

# START SPECTRUM

# A script to make using 256 colors in zsh less painful.
# P.C. Shyamshankar <sykora@lucentbeing.com>
# Copied from http://github.com/sykora/etc/blob/master/zsh/functions/spectrum/

typeset -Ag FX FG BG

FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done

ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-I am the walrus.}

# Show all 256 colors with color number
function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}$ZSH_SPECTRUM_TEXT%f"
  done
}

# Show all 256 colors where the background is set to specific color
function spectrum_bls() {
  for code in {000..255}; do
    print -P -- "$BG[$code]$code: $ZSH_SPECTRUM_TEXT %{$reset_color%}"
  done
}

#END SPECTRUM

if [[ ! -z "$EMACS" ]]; then
  #this sucks, but i just can't convince multi-term to show 256 colors
  LOGIN_COLOR="$fg[cyan]"
  TIME_COLOR="$fg[yellow]"
  DIR_COLOR="$fg[white]"
  GIT_STATUS_COLOR="$fg[magenta]"
  GIT_MODIFIED_COLOR="$fg[red]"
  PROMPT_COLOR="$fg[cyan]"
else
  LOGIN_COLOR="$FG[026]"
  TIME_COLOR="$FG[172]"
  DIR_COLOR="$FG[006]"
  GIT_STATUS_COLOR="$FG[105]"
  GIT_MODIFIED_COLOR="$FG[206]"
  INSERT_MODE_COLOR="$FG[070]"
  CMD_MODE_COLOR="$FG[069]"
  PROMPT_COLOR="$FG[203]"
fi

GIT_PROMPT_PREFIX="${GIT_STATUS_COLOR}["
GIT_PROMPT_SUFFIX="${GIT_STATUS_COLOR}]$reset_color"

# get the name of the branch we are on
function git_prompt_info() {
  local DIRTY_OR_CLEAN=''
  local GIT_STATUS=''

  GIT_STATUS=$(command git status -s --ignore-submodules=dirty 2> /dev/null | tail -n1)

  if [[ -n $GIT_STATUS ]]; then
    DIRTY_OR_CLEAN=" ${GIT_MODIFIED_COLOR}*"
  fi

  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo " $GIT_PROMPT_PREFIX${ref#refs/heads/}$DIRTY_OR_CLEAN$GIT_PROMPT_SUFFIX"
}

if [[ -z "$EMACS" ]]; then
  INSERTMODE="${INSERT_MODE_COLOR}ins$reset_color"
  VIMODE=$INSERTMODE

  function precmd(){
    VIMODE=" ($INSERTMODE)"
  }

  function zle-keymap-select(){
    case $KEYMAP in
      vicmd) VIMODE=" (${CMD_MODE_COLOR}cmd$reset_color)";;
      viins|main) VIMODE=" ($INSERTMODE)"
    esac
    zle reset-prompt
  }
fi

zle -N zle-keymap-select

PROMPT=$'%{$LOGIN_COLOR%}%n@%m %{$TIME_COLOR%}%D{[%H:%M:%S]} %{$reset_color%}%{$DIR_COLOR%}[%~]%{$reset_color%}$(git_prompt_info)${VIMODE}\
%{$PROMPT_COLOR%}-> %{$reset_color%}'
