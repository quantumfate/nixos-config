{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common;
in {
  home-manager.users."${userCfg.userName}" = {
    wayland.windowManager.hyprland = {
      settings = { "exec-once" = [ "waybar" "hyprpaper" ]; };
    };
  };
}
