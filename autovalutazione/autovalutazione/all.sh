#!/bin/bash

clear

#set -e

set -x

./stop.sh;  ./build.sh  && ./run.sh && tail -f nohup.out
