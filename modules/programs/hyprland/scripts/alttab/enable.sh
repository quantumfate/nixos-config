#!/usr/bin/env bash
mkdir -p /tmp/alttab
hyprctl -q --batch "keyword animations:enabled false; keyword unbind ALT, TAB ; keyword unbind ALT SHIFT, TAB"
footclient -a alttab ~/.config/hypr/scripts/alttab/alttab.sh $1
hyprctl --batch -q "dispatch focuswindow address:$(cat /tmp/alttab/address) ; dispatch alterzorder top"
