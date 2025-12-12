#!/bin/sh
window_address=$1
window_title=$2

hyprctl keyword "windowrule[opaque-zen-browser]:match:address $window_adress"
hyprctl keyword "windowrule[transparent-zen-browser]:match:address $window_adress"

case "$window_title" in
    Crunchyroll || Watch on Crunchyroll)
        hyprctl keyword 'windowrule[opaque-zen-browser]:enable true'
        hyprctl keyword 'windowrule[transparent-zen-browser]:enable false'
        ;;
    *)
        hyprctl keyword 'windowrule[opaque-zen-browser]:enable false'
        hyprctl keyword 'windowrule[transparent-zen-browser]:enable true'
        ;;
esac