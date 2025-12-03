#!/bin/sh

APP_NAME="Dofus Launch"
SCRIPT_NAME="dofuslaunch.sh" # Ensure this matches your persistent script's name

# 1. Try to find the running process
PID=$(pgrep -f "$SCRIPT_NAME")

if [ -n "$PID" ]; then
    # Script is running, so kill it (toggle OFF)
    kill $PID
    # Optional: Wait briefly to ensure termination before sending notification
    sleep 0.1
    notify-send --app-name="$APP_NAME" -h string:x-canonical-private-synchronous:sys-notify -u low "Script STOPPED"
else
    # Script is not running, so start it (toggle ON)
    # Note: Use '&' to run it in the background so the wrapper script exits immediately
    ${XDG_CONFIG_HOME}/hypr/scripts/${SCRIPT_NAME} &
    notify-send --app-name="$APP_NAME" -h string:x-canonical-private-synchronous:sys-notify -u low "Script STARTED"
fi