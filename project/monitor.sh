#!/bin/bash

# Load thresholds
source config/thresholds.conf

LOG_FILE="logs/activity.txt"

echo "Monitoring started..." >> $LOG_FILE

while true
do
    ps -eo pid,comm,%cpu,%mem --no-headers | while read pid name cpu mem
    do
        cpu_int=${cpu%.*}
        mem_int=${mem%.*}

        if [[ $cpu_int -gt $CPU_LIMIT || $mem_int -gt $MEM_LIMIT ]]
        then
            time=$(date "+%Y-%m-%d %H:%M:%S")

            # Soft kill
            kill -15 $pid 2>/dev/null
            sleep 2

            # Check if still running
            if ps -p $pid > /dev/null
            then
                kill -9 $pid 2>/dev/null
                action="Force Killed"
            else
                action="Soft Killed"
            fi

            echo "$pid | $name | CPU:$cpu% | MEM:$mem% | $time | $action" >> $LOG_FILE
        fi
    done

    sleep 5
done
