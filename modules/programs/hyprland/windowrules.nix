{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        windowrule = [
          "workspace 5, maximize on, match:class Dofus.x64"
        ];
      };
    };
  };
}
