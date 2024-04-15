#!/bin/bash

echo -e "[!] installing dependencies"
sudo dnf install zsh z git tmux neovim

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install zsh-auosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# start it one to init oh-my-zsh
zsh

echo -e "\n[!] linking config"
ln $(dirname $0)/.zshrc ~/
