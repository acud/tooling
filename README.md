run using:

curl -L https://raw.githubusercontent.com/acud/tooling/main/deployment.sh | bash

quicksync:

screen -L ./quicksync download --node-data ./data

profiling:

wget https://raw.githubusercontent.com/acud/tooling/main/profiling.sh
chmod +x profiling.sh
tt=$(mktemp)
crontab -l > $tt
echo "*/5 * * * * /root/profiling.sh" >> $tt
crontab $tt
rm $tt


