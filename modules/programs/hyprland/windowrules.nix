{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        windowrule = [
          "monitor DP-1, workspace 5, match:class Dofus.x64"
        ];
      };
    };
  };
}
