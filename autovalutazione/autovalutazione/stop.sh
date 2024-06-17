#!/bin/bash

FILE=$(basename $PWD)

#echo "$FILE start: $(date)">>exec.log 
kill $(cat pid/running.pid)
#echo "$FILE end  : $(date)" >>exec.log
