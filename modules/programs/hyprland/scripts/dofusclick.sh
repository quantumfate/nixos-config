#!/bin/sh
hyprctl -q keyword animations:enabled false

dofus_chars=("Rejecter" "Draintouch" "Reminiscer" "Traumafactory" "Memoryfracture" "Miserymaker" )

x_mouse_pos=$(cut -d ":" -f2 <<< $(cut -d " " -f1  <<< $(xdotool getmouselocation)))
y_mouse_pos=$(cut -d ":" -f2 <<< $(cut -d " " -f2  <<< $(xdotool getmouselocation)))

for char in ${dofus_chars[@]}; do
    hyprctl --batch -q "dispatch focuswindow title:Dofus $char ; dispatch alterzorder top"
    sleep 0.25
    xdotool mousemove ${x_mouse_pos} ${y_mouse_pos}
    xdotool click 1
done

hyprctl -q keyword animations:enabled true