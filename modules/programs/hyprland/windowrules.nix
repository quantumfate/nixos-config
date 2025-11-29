{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        windowrule = [
          "workspace 3 silent, match:class spotify"
          "workspace 3 silent, match:class discord"
          "workspace 4, match:class Ankama Launcher"
          "workspace 5, center on, content game, decorate off, no_anim on, match:class Dofus.x64"
        ];
      };
    };
  };
}
