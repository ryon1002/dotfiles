#!/bin/bash

ln -nfs ~/dotfiles/.zshrc ~/.zshrc
ln -nfs ~/dotfiles/.vimrc ~/.vimrc
rm -rf ~/.config/byobu
ln -nfs ~/dotfiles/.byobu ~/.config/byobu
