#!/usr/bin/env bash
mkdir -p /tmp/alttab
hyprctl -q --batch "keyword animations:enabled false; keyword unbind ALT, TAB ; keyword unbind ALT SHIFT, TAB"

if [ "$(hyprctl activewindow -j | jq -r ".class")" = "Dofus.x64" ]; then
    footclient -a alttab ~/.config/hypr/scripts/alttab/alttab.sh $1 "| select(.class == 'Dofus.x64')"
else
    footclient -a alttab ~/.config/hypr/scripts/alttab/alttab.sh $1
fi

hyprctl --batch -q "dispatch focuswindow address:$(cat /tmp/alttab/address) ; dispatch alterzorder top"
