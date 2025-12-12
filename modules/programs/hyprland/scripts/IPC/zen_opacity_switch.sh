#!/bin/sh
window_address=$1
window_title=$2

echo "hey" > ~/test.txt

case "$window_title" in
    *Crunchyroll*)
        hyprctl keyword 'windowrule[opaque-zen-browser]:enable true'
        hyprctl keyword 'windowrule[transparent-zen-browser]:enable false'
        ;;
    *)
        hyprctl keyword 'windowrule[opaque-zen-browser]:enable false'
        hyprctl keyword 'windowrule[transparent-zen-browser]:enable true'
        ;;
esac