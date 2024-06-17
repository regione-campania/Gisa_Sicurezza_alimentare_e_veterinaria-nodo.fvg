#!/bin/bash

FILE=$(basename $PWD)

#echo "$FILE start: $(date)">>exec.log 
nohup bin/${FILE}  &
echo $! >pid/running.pid
#echo "$FILE end  : $(date)" >>exec.log
