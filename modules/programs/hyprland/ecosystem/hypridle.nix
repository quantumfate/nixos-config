{ config, ... }:

let
  userCfg = config.common.user;
  suspendListener = {
    "quantum-desktop" = {
      timeout = 1800; # 30min
      on-timeout = "systemctl suspend"; # suspend pc
      on-resume = "hyprctl --batch 'dispatch exec nmcli c down Wired connection 1; dispatch exec sleep 2; dispatch exec nmcli c up Wired connection 1'";

    };
    "default" = {
      timeout = 1800; # 30min
      on-timeout = "systemctl suspend"; # suspend pc
      on-resume = "hyprctl --batch 'dispatch exec nmcli c down Wired connection 1; dispatch exec sleep 2; dispatch exec nmcli c up Wired connection 1'";

    };
  };

in
{
  home-manager.users."${userCfg.name}" = {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
        };

        listener = [
          {
            timeout = 150; # 2.5min.
            on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; # turn off keyboard backlight.
            on-resume = "brightnessctl -rd rgb:kbd_backlight"; # turn on keyboard backlight.
          }
          {
            timeout = 300;
            on-timeout = "loginctl lock-session && (pidof hyprlock || hyprlock)";
            on-resume = "loginctl unlock-session";
          }
          {
            timeout = 330; # 5.5min
            on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r"; # screen on when activity is detected after timeout has fired.
          }
          suspendListener.${config.networking.hostName} or suspendListener.default
        ];
      };
    };
  };
}
