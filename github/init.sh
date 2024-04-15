#!/bin/bash

echo -e "[!] gernating ED25519 key with 100 rounds"
ssh-keygen -t ed25519 -a 100 -f ~/.ssh/github

# alterantive but not recommended
# echo "[!] gernating RSA key with 4096 bits and 100 rounds"
# ssh-keygen -t rsa -b 4096 -o -a 100 -f ~/.ssh/github

echo -e "\n[!] setting username and mail"
git config --global user.name "Sebastian Schirle"
git config --global user.email "60340491+AboveYou@users.noreply.github.com"
git config --list