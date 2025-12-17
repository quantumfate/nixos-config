{ config, pkgs, ... }:

let
  userCfg = config.common.user;
  scriptLocation = "/home/${userCfg.name}/.config/hypr/scripts";
  catppuccin = config.theme.catppuccin;
in {
  home-manager.users."${userCfg.name}" = {
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
                    "speaker": "",
                    "hifi": "",
                    "headset": "",
                    "phone": "",
                    "portable": "",
                    "car": "",
                    "default": ["", "", ""]
                },
                "scroll-step": 5.0,
                "on-click": "pamixer -t",
                "on-click-right": "kitty wiremix",
                "on-scroll-up": "${scriptLocation}/wrapper/volume.sh --inc",
                "on-scroll-down": "${scriptLocation}/wrapper/volume.sh --dec",
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
                        "months": "<span color='${catppuccin.hex.teal}'><b>{}</b></span>",
                        "days": "<span color='${catppuccin.hex.peach}'><b>{}</b></span>",
                        "weeks": "<span color='${catppuccin.hex.green}'><b>W{}</b></span>",
                        "weekdays": "<span color='${catppuccin.hex.pink}'><b>{}</b></span>",
                        "today": "<span color='${catppuccin.hex.yellow}'><b><u>{}</u></b></span>"
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
                "spacing": 6,
                "show-passive-items": true,
                "icons": {
                    "blueman": "bluetooth",
                }
            },
            "custom/mako": {
                "exec": "${scriptLocation}/interface/mako.sh",
                "on-click": "makoctl mode -t do-not-disturb",
                "restart-interval": 1
            },
            "battery": {
                "bat": "BATT",
                "interval": 60,
                "states": {
                "warning": 30,
                "critical": 15
                },
                "format": "{capacity}% {icon}",
                "format-icons": ["", "", "", "", ""],
                "max-length": 25
            },
            "custom/lock": {
                "format": "<span color='${catppuccin.hex.teal}'>  </span>",
                "on-click": "hyprlock",
                "tooltip": true,
                "tooltip-format": "Lock the screen."
                },
            "custom/reboot": {
                "format": "<span color='${catppuccin.hex.yellow}'>  </span>",
                "on-click": "hyprshutdown -t 'Restarting...' --post-cmd 'reboot'",
                "tooltip": true,
                "tooltip-format": "Reboot the system."
            },
            "custom/power": {
                "format": "<span color='${catppuccin.hex.red}'>  </span>",
                "on-click": "hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown -P 0'",
                "tooltip": true,
                "tooltip-format": "Power off the system."
            }
        }
      '';
    };
  };
}
