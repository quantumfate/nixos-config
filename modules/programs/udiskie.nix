{ config, pkgs, lib, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
in {
  services.udisks2.enable = true;

  home-manager.users."${userCfg.userName}" = {
    services.udiskie = {
      enable = true;
      automount = true;
    };
  };
}
