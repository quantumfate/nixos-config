{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        windowrule = [
          "workspace 5, float off, tile off, min_size 2536 1376, min_size 2536 1376, match:class Dofus.x64"
        ];
      };
    };
  };
}
