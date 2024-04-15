#!/bin/bash

echo -e "[!] installing dependencies"
sudo dnf install neovim nodejs

# install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


# create dir if not existent
mkdir ~/.config/nvim/

echo -e "\n[!] linking config"
ln $(dirname $0)/init.vim ~/.config/nvim/
