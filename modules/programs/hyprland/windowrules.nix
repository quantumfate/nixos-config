{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        windowrule = [
          "monitor DP-1, fullscreen, workspace 5, nomaxsize, fullscreenstate 3 3, class:Dofus.x64"
        ];
      };
    };
  };
}
