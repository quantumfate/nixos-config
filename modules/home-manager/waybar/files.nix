let scriptLocation = "/home/quantum/.config/waybar/scripts";
in {
  home.file.".config/waybar/scripts/" = {
    source = ./scripts;
    recursive = true;
  };

  home.file.".config/waybar/modules" = {
    enable = true;
    text = ''
{
    "custom/dunst": {
        "exec": "${scriptLocation}/dunst.sh",
        "on-click": "dunstctl set-paused toggle",
        "restart-interval": 1
    },
    "hyprland/workspaces": {
        "format": "<sub>{icon}</sub>",
        "format-window-separator": "\n",
        "window-rewrite-default": "",
        "window-rewrite": {
            "title<.*youtube.*>": "", 
            "class<brave-browser>": "", 
            "class<brave-browser> title<.*github.*>": "",
            "foot": "", 
            "code": "󰨞"
        }
    },
    "hyprland/window": {
        "format": "{}",
        "rewrite": {
            "(.*) - Brave": "🌎 $1",
            "(.*) - fish": "> [$1]",
            "(.*) - Discord": " [$1]"
        },
    "separate-outputs": true
    },
    "hyprland/language": {
        "format": "Lang: {}",
        "format-en": "EN",
        "keyboard-name": "kbdfans-kbd75-rev2"
    },
    "clock": {
        "format": "{:%H:%M}  ",
        "format-alt": "{:%A, %B %d, %Y (%R)}  ",
        "tooltip-format": "\n<span size='10pt' font='Inconsolata Nerd Font Regular'>{calendar}</span>",
        "calendar": {
            "mode": "year",
            "mode-mon-col": 3,
            "weeks-pos": "right",
            "on-scroll": 1,
            "on-click-right": "mode",
            "format": {
                "months": "<span color='#cdd6f4'><b>{}</b></span>",
                "days": "<span color='#fab387'><b>{}</b></span>",
                "weeks": "<span color='#a6e3a1'><b>W{}</b></span>",
                "weekdays": "<span color='#f5c2e7'><b>{}</b></span>",
                "today": "<span color='#f9e2af'><b><u>{}</u></b></span>"
            }
        },
        "actions":  {
            "on-click-right": "mode",
            "on-click-forward": "tz_up",
            "on-click-backward": "tz_down",
            "on-scroll-up": "shift_up",
            "on-scroll-down": "shift_down"
        }
    },
    "custom/spotify": {
        "exec": "/usr/bin/python3 ${scriptLocation}/mediaplayer.py --player spotify",
        "format": "{}  ",
        "return-type": "json",
        "on-click": "playerctl play-pause",
        "on-scroll-up": "playerctl next",
        "on-scroll-down": "playerctl previous"
    },
    "cpu": {
        "interval": 4,
        "format": "{icon0}{icon1}{icon2}{icon3} {usage:>2}% ",
        "format-icons": ["▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"]
        },
    "disk": {
        "interval": 30,
        "format": " {free}"
    },
    "memory": {
        "interval": 10,
        "format": " {used:0.1f}G "
    },
    "network": {
        "interval": 5,
        "format-wifi": "  {essid}",
        "format-ethernet": " {ipaddr}/{cidr}",
        "format-linked": " {ifname} (No IP)",
        "format-disconnected": "睊 Disconnected",
        "format-disabled": "睊 Disabled",
        "format-alt": " {bandwidthUpBits} |  {bandwidthDownBits}",
        "tooltip-format": " {ifname} via {gwaddr}",
        "on-right-click": "nm-connection-editor"
    },
    "custom/weather": {
        "format": "{}",
        "format-alt": "{alt}: {}",
        "format-alt-click": "click-right",
        "interval": 1800,
        "return-type": "json",
        "exec": "${scriptLocation}/weather.sh 'hamburg'",
        "exec-if": "ping wttr.in -c1"
    },
    "pulseaudio": {
        "format": "{icon} {volume}",
        "format-muted": " Mute",
        "format-bluetooth": " {volume}% {format_source}",
        "format-bluetooth-muted": " Mute",
        "format-source": " ",
        "format-source-muted": "",
        "format-icons": {
            "headphone": "",
            "hands-free": "",
            "speaker": "ﰝ",
            "hifi": "醙",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", "", ""]
        },
        "scroll-step": 5.0,
        "on-click": "pamixer -t",
        "on-click-right": "pavucontrol",
        "on-scroll-up": "${scriptLocation}/volume.sh --inc",
        "on-scroll-down": "${scriptLocation}/volume.sh --dec",
        "smooth-scrolling-threshold": 1
    },
    "tray": {
        "icon-size": 14,
        "spacing": 6
    }
}
    '';
  };
}
