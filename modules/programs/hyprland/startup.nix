{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = { "exec-once" = [ "waybar" "hyprpaper" "xrandr --output DP-1 --primary" "discord" "spotify" ]; };
    };
  };
}
