#!/bin/bash

echo -e "[!] installing dependencies"
sudo dnf install gcc gdb

# install gef
bash -c "$(curl -fsSL https://gef.blah.cat/sh)"

echo -e "\n[!] linking config"
ln $(dirname $0)/.gef.rc ~/
