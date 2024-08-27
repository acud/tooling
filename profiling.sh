#!/bin/bash

profile=sm-profile.$(date +%s)

wget localhost:6060/debug/pprof/profile\?seconds=60
