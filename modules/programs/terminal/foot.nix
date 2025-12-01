{ config, lib, pkgs, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
  colors = config.colors.catppuccin.mocha;
in {

  home-manager.users."${userCfg.name}" = {

    programs.foot = {
      enable = true;
      settings = { 
        main = {
          font = "${config.common.style.fontFamily}:size=14";
          pad = "15x15";
        };
      };
    };
  };
}
