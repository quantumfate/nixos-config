#!/bin/sh
hyprctl -q keyword animations:enabled false

mapfile -t dofus_chars <<< "$(
    hyprctl -j clients | jq -r ' .[] | select(.class == "Dofus.x64") | "\(.title)"'
)"

x_mouse_pos=$(cut -d ":" -f2 <<< $(cut -d " " -f1  <<< $(xdotool getmouselocation)))
y_mouse_pos=$(cut -d ":" -f2 <<< $(cut -d " " -f2  <<< $(xdotool getmouselocation)))

for "$char" in "${dofus_chars[@]}"; do
    address=$(hyprctl -j clients | jq -r " .[] | select(.title == \"$char\") | \"\(.address)\"")
    if [ -n "$address" ]; then
        hyprctl --batch -q "dispatch focuswindow title:$char ; dispatch alterzorder top"
        sleep 0.25
        xdotool mousemove ${x_mouse_pos} ${y_mouse_pos}
        xdotool click 1
    fi
done

hyprctl -q keyword animations:enabled true