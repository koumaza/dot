#!/usr/bin/bash
#### ENV


#pyver=3.8.2

#### INSTALLATION
cat - << EOS >> /etc/apk/repositories
http://dl-cdn.alpinelinux.org/alpine/edge/main
http://dl-cdn.alpinelinux.org/alpine/edge/community
http://dl-cdn.alpinelinux.org/alpine/edge/testing
EOS
apk --no-cache add --virtual build-dependencies curl build-base \
coreutils findutils fish vim neovim curl wget bash gcc make g++ tmux zlib



# Fish
mkdir -p ~/.config/fish/
wget -O  ~/.config/fish/config.fish \
"URI" \
cat gitpod-alpine.sh >> ~/.config/fish/config.fish

# Py
git clone https://github.com/pyenv/pyenv.git ~/.pyenv --depth 1
#pyenv install $pyver

# Live share
wget -O ~/vsls-reqs https://aka.ms/vsls-linux-prereq-script && chmod +x ~/vsls-reqs && ~/vsls-reqs

