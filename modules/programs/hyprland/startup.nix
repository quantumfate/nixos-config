{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        "exec-once" = [
          "xrandr --output DP-1 --primary"
          "waybar"
          "hyprpaper"
          "discord"
          "spotify"
          "keepassxc"
        ];
      };
    };
  };
}
