#!/bin/bash

# Attempt to kill the script gracefully with SIGINT
pkill -SIGINT dofuslaunch.sh

if [ $? -ne 0 ]; then
    notify-send --app-name=Dofus-Launch -h string:x-canonical-private-synchronous:sys-notify -u low "Dofus Launch done"
    exit 1
fi
./dofuslaunch.sh &