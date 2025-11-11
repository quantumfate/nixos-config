{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
  scriptLocation = "/home/${userCfg.userName}/.config/waybar/scripts";
  colors = config.colors.catppuccin.mocha;
in {
  home-manager.users."${userCfg.userName}" = {
    home.file.".config/waybar/modules" = {
      enable = true;
      text = ''
        {
            "hyprland/workspaces": {
                "format": "{icon}",
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
            "cpu": {
                "interval": 4,
                "format": "{usage:>2}% ",
                "format-icons": ["▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"]
                },
            "memory": {
                "interval": 10,
                "format": "{used:0.1f}G "
            },
            "disk": {
                "interval": 30,
                "format": "{free} "
            },
            "network": {
                "interval": 5,
                "format-wifi": "{essid}  ",
                "format-ethernet": "{ipaddr}/{cidr} 󱎔",
                "format-linked": " {ifname} (No IP)",
                "format-disconnected": "Disconnected ",
                "format-disabled": "Disabled ",
                "format-alt": " {bandwidthUpBits} |  {bandwidthDownBits}",
                "tooltip-format": "{ifname} via {gwaddr}",
                "on-right-click": "nm-connection-editor"
            },
            "hyprland/window": {
                "format": "{}",
                "rewrite": {
                    "(.*) - Brave": "$1",
                    "(.*) - fish": "> [$1]",
                    "(.*) - alacritty": "> [$1]",
                    "(.*) - Discord": " [$1]"
                },
            "separate-outputs": true
            },
            "hyprland/language": {
                "format": "Lang: {}",
                "format-en": "EN",
                "keyboard-name": "kbdfans-kbd75-rev2"
            },
            "pulseaudio": {
                "format": "{volume} {icon}",
                "format-muted": "Mute ",
                "format-bluetooth": "{volume}% {format_source} ",
                "format-bluetooth-muted": "Mute ",
                "format-source": " ",
                "format-source-muted": " ",
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
            "tray": {
                "icon-size": 14,
                "spacing": 6
            },
            "custom/mako": {
                "exec": "${scriptLocation}/mako.sh",
                "on-click": "makoctl mode -t do-not-disturb",
                "restart-interval": 1
            },
            "custom/lock": {
                "format": "<span color='${colors.teal.hex}'>  </span>",
                "on-click": "hyprlock",
                "tooltip": true,
                "tooltip-format": "Lock the screen."
                },
            "custom/reboot": {
                "format": "<span color='${colors.yellow.hex}'>  </span>",
                "on-click": "systemctl reboot",
                "tooltip": true,
                "tooltip-format": "Reboot the system."
            },
            "custom/power": {
                "format": "<span color='${colors.red.hex}'>  </span>",
                "on-click": "systemctl poweroff",
                "tooltip": true,
                "tooltip-format": "Power off the system."
            }
        }
      '';
    };
  };
}
