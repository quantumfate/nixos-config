{ config, ... }:

let
  hostName = config.networking.hostName;
  mainUser = config.mainUser;
in {
  home-manager.users."${mainUser}" = {
    wayland.windowManager.hyprland = {
      settings = { "exec-once" = [ "waybar" ]; };
    };
  };
}
