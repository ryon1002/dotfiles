#!/bin/bash

sudo apt update
sudo apt install -y zsh vim byobu curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

