#!/bin/bash

sudo apt update
sudo apt install -y zsh vim byobu curl direnv git
ln -nfs ~/dotfiles/.vimrc ~/.vimrc
ln -nfs ~/dotfiles/.zsh/.zshrc ~/.zshrc

mkdir ~/.config
# nvim
sudo apt install -y snap
sudo snap install nvim --classic
ln -nfs ~/dotfiles/.config/nvim ~/.config/nvim
curl -fLo ~/.config/nvim/autoload/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim

# sheldon
curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
ln -nfs ~/dotfiles/.config/sheldon ~/.config/sheldon

# starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes
ln -nfs ~/dotfiles/.config/starship/starship.toml ~/.config/starship.toml

# mise
curl https://mise.jdx.dev/install.sh | sh

# rye
# curl -sSf https://rye-up.com/get | sh

# tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# byobu link
rm -rf ~/.config/byobu
ln -nfs ~/dotfiles/.config/byobu ~/.config/byobu
