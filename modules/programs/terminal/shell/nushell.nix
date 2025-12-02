{ config, pkgs, lib, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {

  config = {
    home-manager.users."${userCfg.name}" = {
      programs.nushell = {
        enable = true;
      };
    };
  };
}
