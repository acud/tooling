#!/bin/bash
#

logfile=sm-log.$(date +%s)

screen -L -Logfile $logfile ./build/go-spacemesh --listen=/ip4/0.0.0.0/tcp/5000 --config=config.mainnet.json -d=/root/data/node --log-encoder=json --pprof-server --metrics --p2p-metrics --p2p-accept-queue=64 --smeshing-start --no-main-override --smeshing-coinbase=sm1qqqqqq99r0r6nrkfyglxgpgvp6nun88xre08k4sz2gk45
