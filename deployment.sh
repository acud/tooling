#!/bin/bash

apt-get update
apt-get install -y gcc docker.io neovim unzip ocl-icd-opencl-dev git-lfs make ca-certificates curl wget screen jq

curl -LO https://go.dev/dl/go1.22.5.linux-amd64.tar.gz
rm -rf /usr/local/go; tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo 'export PATH=$PATH:/usr/local/go/bin' >>~/.bashrc
source ~/.bashrc


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

echo 'export GOPATH="/root/go"' >>~/.bashrc
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
echo 'export PATH=$PATH:$GOPATH/bin:/root/.bin' >>~/.bashrc
mkdir ~/.bin
export PATH=$PATH:$GOPATH/bin:/root/.bin

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
