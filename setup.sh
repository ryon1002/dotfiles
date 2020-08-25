#!/bin/bash

ln -nfs ~/dotfiles/.vimrc ~/.vimrc
ln -nfs ~/dotfiles/.zsh/.zshrc ~/.zshrc
rm -rf ~/.config/byobu
ln -nfs ~/dotfiles/.byobu ~/.config/byobu
