{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
in {
  home-manager.users."${userCfg.userName}" = {
    wayland.windowManager.hyprland = {
      settings = { "exec-once" = [ "waybar" ]; };
    };
  };
}
