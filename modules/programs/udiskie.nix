{ config, pkgs, lib, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {
  services.udisks2.enable = true;

  home-manager.users."${userCfg.name}" = {
    services.udiskie = {
      enable = true;
      automount = true;
    };
  };
}
