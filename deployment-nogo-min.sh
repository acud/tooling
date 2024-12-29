#!/bin/bash

apt-get update
apt-get install -y gcc docker.io neovim unzip ocl-icd-opencl-dev git-lfs make ca-certificates curl wget screen jq

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
	sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
apt-get update

apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl enable --now docker

echo "alias v='nvim'" >>~/.bashrc
echo "alias co='git checkout'" >>~/.bashrc
echo "alias vi='nvim'" >>~/.bashrc
echo "alias gs='git status'" >>~/.bashrc
echo "alias gc='git commit -am'" >>~/.bashrc
echo "alias gp='git push'" >>~/.bashrc
echo "alias co='git checkout'" >>~/.bashrc
echo "alias gb='git branch'" >>~/.bashrc
echo "alias gd='git diff'" >>~/.bashrc
echo "alias gl='git log'" >>~/.bashrc
echo "alias gll='git log --no-decorate --oneline'" >>~/.bashrc
echo "alias gca='git commit --amend'" >>~/.bashrc
mkdir ~/.bin
