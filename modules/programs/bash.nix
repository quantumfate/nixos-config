{ config, pkgs, lib, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {
    programs.bash = {
      enable = true;
      shellAliases = { btw = "echo i use hyprland btw"; };
      profileExtra = ''
        if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
          exec hyprland
        fi
      '';
    };
  };
}
