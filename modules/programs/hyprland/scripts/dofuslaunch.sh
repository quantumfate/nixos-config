#!/bin/sh

APP_NAME="Dofus Launch"
dofus_chars=("Rejecter" "Draintouch" "Reminiscer" "Traumafactory" "Memoryfracture" "Miserymaker" )
char_count=0

process_window () {
  # openwindow>>56386538dc70,5,Dofus.x64,Dofus
  window_address="0x$(cut -d ',' -f1 <<< $(cut -d '>' -f3 <<< $1))"
  client_pid=$(hyprctl -j clients | jq --arg addr "$window_address" '.[] | select(.address == $addr)' | jq -r '.pid')
  window_id=$(xdotool search --pid "$client_pid")
  xdotool set_window -name "Dofus ${dofus_chars[$char_count]}" "$window_id"   
  ((char_count++))
  
  if [ $char_count -eq 6 ]; then
    notify-send --app-name="$APP_NAME" -h string:x-canonical-private-synchronous:sys-notify -u low "Done"
    exit 1
  fi
}

handle() {
  case $1 in
    openwindow*Dofus) process_window $1;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done