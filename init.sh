#!/bin/bash

if [[ -f ~/.localenv.properties ]]; then
  source ~/.localenv.properties
fi
export TERM=xterm-256color
byobu
