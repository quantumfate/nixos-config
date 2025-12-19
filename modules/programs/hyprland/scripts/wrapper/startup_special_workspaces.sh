#!/usr/bin/env bash

applications=("keepassxc" "spotify" "whatsapp-electron" "vesktop")

for app in ${applications[@]}; do
    (
        hyprctl keyword "windowrule[workspace-silent-${app}]:enable true"
        hyprctl keyword "windowrule[workspace-${app}]:enable false"
        sleep 0.5

        exec $app &
        if [ "$app" = "vesktop" ]; then
            sleep 6
        else
            sleep 2
        fi

        hyprctl keyword "windowrule[workspace-silent-${app}]:enable false"
        hyprctl keyword "windowrule[workspace-${app}]:enable true"
    ) &
done
