#!/bin/sh

APP_NAME="IPC Wrapper"
SCRIPTDIR=${XDG_CONFIG_HOME}/hypr/scripts
IPC_SCRIPTDIR=${SCRIPTDIR}/IPC

# if windowtitlev2
# get adress
# check if window is of class zen-browser
# is title crunchyroll?
# yes? override opacity to 1.0
# no? override opacity to 0.1

identify_window_initial_class() {
    window_address="0x$(cut -d ',' -f1 <<< $(cut -d '>' -f2 <<< $1))"
    window_title="$(cut -d ',' -f2 <<< $(cut -d '>' -f2 <<< $1))"
    class=hyprctl -j clients | jq -r " .[] | select(.address == \"$window_address\") | \(.initialClass)"
    
    case $class in 
      zen-twilight) "${IPC_SCRIPTDIR}/zen_opacity_switch.sh $window_address $window_title";; 
    esac
}

handle() {
  case $1 in
    windowtitlev2) identify_window_initial_class $1;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done