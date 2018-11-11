#!/bin/bash

git submodule update --init

if [ ! -f ~/.vimrc ]; then
  ln -s $PWD/init.vim ~/.vimrc
fi

if [[ ! -d ~/.config/nvim ]]; then
  mkdir -p ~/.config
  ln -s $PWD ~/.config/nvim
fi

if which nvim &> /dev/null; then
  nvim -c "PlugInstall"
else
  vim -c "PlugInstall"
fi
