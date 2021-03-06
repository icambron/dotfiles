#!/bin/bash

shopt -s dotglob
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for f in *
do
  if [[ $f =~ \.(rb|sh|md)$ ]] || [[ $f =~ ^\.git ]]; then
    continue
  fi

  dest=$f

  if [[ $f =~ ^renamed-(.*) ]]; then
    dest=${BASH_REMATCH[1]}
  fi

  echo "Linking $f to ~/$dest"
  ln -sfn $dir/$f ~/$dest

done

vim +PlugInstall +qall
