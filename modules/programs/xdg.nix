{ config, pkgs, lib, inputs, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common;
in {

  home-manager.users."${userCfg.userName}" = {
    xdg = {
      enable = true;
      mime.enable = true;
    };
  };
}
