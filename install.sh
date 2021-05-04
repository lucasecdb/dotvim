#!/bin/bash

if [[ ! -d ~/.config/nvim ]]; then
  mkdir -p ~/.config
  ln -s $PWD ~/.config/nvim
fi

if which nvim &> /dev/null; then
  nvim -c "PackerSync"
else
  echo "This repository does not work with VIM"
fi
