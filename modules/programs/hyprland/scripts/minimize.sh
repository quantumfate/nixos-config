activeWindow = $(hyprctl activewindow -j | jq -r ".class")

if [ "$activeWindow" = "steam" ]; then
    xdotool getactivewindow windowunmap
else
    hyprctl dispatch killactive ""
fi