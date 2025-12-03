#!/bin/sh

notify-send --app-name=Dofus-Launch -h string:x-canonical-private-synchronous:sys-notify -u low "Dofus Launch Script started"

dofus_chars=("Rejecter" "Draintouch" "Reminiscer" "Traumafactory" "Memoryfracture" "Miserymaker" )
char_count=0

# openwindow>>56386538dc70,5,Dofus.x64,Dofus

process_window () {
  window_address="0x$(cut -d ',' -f1 <<< $(cut -d '>' -f3 <<< $1))"
  client_pid=$(hyprctl -j clients | jq --arg addr "$window_address" '.[] | select(.address == $addr)' | jq -r '.pid')

  echo "address: $window_address" 
  echo "pid: $client_pid" 
  window_id=$(xdotool search --pid "$client_pid")
  xdotool set_window -name "Dofus ${dofus_chars[$char_count]}" "$window_id"   
  echo "window name: Dofus ${dofus_chars[$char_count]}" 
  ((char_count++))
  
  # Todo exit script when done 
}

handle() {
  case $1 in
    openwindow*Dofus) process_window $1;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done


trap "$(notify-send --app-name=Dofus-Launch -h string:x-canonical-private-synchronous:sys-notify -u low "Dofus Launch Script exited")" EXIT