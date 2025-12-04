#!/bin/sh

APP_NAME="Dofus Launch"
SCRIPT_NAME="dofuslaunch.sh"

PID=$(pgrep -f "$SCRIPT_NAME")

if [ -n "$PID" ]; then
    kill $PID
    sleep 0.1
    notify-send --app-name="$APP_NAME" -h string:x-canonical-private-synchronous:sys-notify -u low "Script STOPPED"
else
    exec "${XDG_CONFIG_HOME}/hypr/scripts/${SCRIPT_NAME}" &
    notify-send --app-name="$APP_NAME" -h string:x-canonical-private-synchronous:sys-notify -u low "Script STARTED"
fi