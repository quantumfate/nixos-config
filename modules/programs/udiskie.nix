{ config, pkgs, lib, ... }:

let
  cfg = config.userPrograms.udiskie;
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
in {
  options.userPrograms.udiskie.enable =
    lib.mkEnableOption "Udiskie service to auto mount external drives.";


  services.udisks2.enable = cfg.enable;

  home-manager.users."${userCfg.userName}" = {
    services.udiskie = {
      enable = cfg.enable;
      automount = true;
    };
  };
}
