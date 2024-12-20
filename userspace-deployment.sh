#!/bin/bash

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
	sudo tee /etc/apt/sources.list.d/docker.list >/dev/null


sudo apt-get update
# sudo apt-get install -y gcc docker.io neovim unzip ocl-icd-opencl-dev git-lfs make ca-certificates curl wget screen jq docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo apt-get install -y gcc  neovim unzip ocl-icd-opencl-dev git-lfs make ca-certificates curl wget screen jq docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

curl -LO https://go.dev/dl/go1.22.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go;sudo tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:$HOME/.bin' >>~/.bashrc
source ~/.bashrc

echo "export GOPATH=\"$HOME/go\"" >>~/.bashrc
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

source ~/.bashrc
mkdir -p ~/go/src/github.com/spacemeshos
cd ~/go/src/github.com/spacemeshos/
git clone https://github.com/spacemeshos/go-spacemesh.git
cd go-spacemesh
make install
make build
touch ~/.netrc
cd ~
ln -s go/src/github.com/spacemeshos/go-spacemesh smh
mkdir -p node/data
cp smh/build/* node/ 
cd node
wget https://www.sqlite.org/2024/sqlite-tools-linux-x64-3460100.zip
unzip sqlite-tools-linux-x64-3460100.zip

go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest

qsv="v0.1.16"
wget https://github.com/spacemeshos/quicksync-rs/releases/download/$qsv/quicksync-linux-$qsv.zip
unzip -o quicksync-linux-$qsv.zip && rm quicksync-linux-$qsv.zip
chmod +x quicksync
curl -LO https://raw.githubusercontent.com/acud/tooling/main/go-spacemesh.service
mv go-spacemesh.service /etc/systemd/system/
systemctl enable go-spacemesh.service
curl -LO https://configs.spacemesh.network/config.mainnet.json
echo "done!"
echo "to quicksync, run: screen -L ./quicksync download --node-data ./data"
