#!/bin/bash

profile=sm-profile.$(date +%s)

wget -O /root/profiles/$profile localhost:6060/debug/pprof/profile\?seconds=60
