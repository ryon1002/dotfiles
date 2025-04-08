#!/bin/bash

if [[ -f ~/.localenv.properties ]]; then
  source ~/.localenv.properties
else
  source ~/dotfiles/.default_localenv.properties
fi
export TERM=xterm-256color
tmux

