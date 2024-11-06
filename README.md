run using:

curl -L https://raw.githubusercontent.com/acud/tooling/main/deployment.sh | bash
curl -L https://raw.githubusercontent.com/acud/tooling/main/userspace-deployment.sh | bash

quicksync:

screen -L ./quicksync download --node-data ./data

profiling:

wget https://raw.githubusercontent.com/acud/tooling/main/profiling.sh
chmod +x profiling.sh
mkdir /root/profiles
tt=$(mktemp)
crontab -l > $tt
echo "*/5 * * * * /root/profiling.sh" >> $tt
crontab $tt
rm $tt

stop copy restart
systemctl stop go-spacemesh-0.service ; cp smh/build/* ./node/; systemctl start go-spacemesh-0.service
