#!/usr/bin/env bash

applications=("keepassxc" "spotify" "whatsapp-electron" "vesktop" "proton-pass" "proton-mail")

for app in ${applications[@]}; do
    (
        sleeptimer=0
        if [ "$app" = "vesktop" ]; then
            sleeptimer=8
        else
            sleeptimer=3
        fi

        wrkspc=""
        if [[ "$app" = "proton-pass" || "$app" = "proton-mail" ]]; then;
            wrkspc="proton"
        else
            wrkspc=$app
        fi

        hyprctl keyword "windowrule[workspace-silent-${wrkspc}]:enable true"
        hyprctl keyword "windowrule[workspace-${wrkspc}]:enable false"
        sleep 0.5

        exec $app &
        sleep $sleeptimer

        hyprctl keyword "windowrule[workspace-silent-${wrkspc}]:enable false"
        hyprctl keyword "windowrule[workspace-${wrkspc}]:enable true"
    ) &
done
