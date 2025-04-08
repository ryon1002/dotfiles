#!/bin/bash

sudo apt update
sudo apt install -y zsh vim curl direnv git tmux pipx
sudo apt install -y build-essential pkg-config libssl-dev 
ln -nfs ~/dotfiles/.vimrc ~/.vimrc
ln -nfs ~/dotfiles/.zsh/.zshrc ~/.zshrc

mkdir -p ~/.config
mkdir -p ~/.local

# nvim
curl -L https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-x86_64.tar.gz | tar -xz -C ~/.local
mv ~/.local/nvim-linux-x86_64 ~/.local/nvim

# rust and cargo-based install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
cargo install eza bottom sheldon

# sheldon
ln -nfs ~/dotfiles/.config/sheldon ~/.config/sheldon

# starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes
ln -nfs ~/dotfiles/.config/starship/starship.toml ~/.config/starship.toml

# mise
curl https://mise.jdx.dev/install.sh | sh

# tpm
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ln -nfs ~/dotfiles/.config/tmux/.tmux.conf ~/.tmux.conf
fi

# uv
pipx install uv

# nvim settings
ln -nfs ~/dotfiles/.config/nvim ~/.config/nvim
ln -nfs ~/.local/nvim/bin/nvim ~/.local/bin/nvim
curl -fLo ~/.config/nvim/autoload/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim
~/.local/bin/nvim --headless "+JetpackSync" +qa

# other settings
if [[ ! -f ~/.localenv.properties ]]; then
  cp ~/dotfiles/.default_localenv.properties ~/.localenv.properties
fi
