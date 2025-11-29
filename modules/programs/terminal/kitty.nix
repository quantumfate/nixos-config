{ config, lib, pkgs, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
  colors = config.colors.catppuccin.mocha;
in {

  home-manager.users."${userCfg.name}" = {

    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      font = {
        name = "${userCfg.style.fontFamily}";
        size = 13;
      }; 
    };
  };
}
