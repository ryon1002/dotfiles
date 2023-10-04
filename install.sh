#!/bin/bash

sudo apt update
sudo apt install -y zsh vim byobu curl direnv
ln -nfs ~/dotfiles/.vimrc ~/.vimrc
ln -nfs ~/dotfiles/.zsh/.zshrc ~/.zshrc
rm -rf ~/.config/byobu
ln -nfs ~/dotfiles/.config/byobu ~/.config/byobu

mkdir ~/.config
# nvim
sudo apt install -y snap
sudo snap install nvim --classic
ln -nfs ~/dotfiles/.config/nvim/ ~/.config/nvim/
curl -fLo ~/.config/nvim/autoload/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim

# sheldon
curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
ln -nfs ~/dotfiles/.config/sheldon ~/.config/sheldon

# starship
curl -sS https://starship.rs/install.sh | sh
ln -nfs ~/dotfiles/.config/starship/starship.toml ~/.config/starship.toml

# rtx
curl https://rtx.pub/rtx-latest-linux-x64 > ~/.local/bin/rtx; chmod +x ~/.local/bin/rtx
