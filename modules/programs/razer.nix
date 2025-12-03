{ config, lib, pkgs, ... }:

let
  cfg = config.common.modules.razer;
  userCfg = config.common.user;
in {
  config = lib.mkIf cfg.enable {
    hardware.openrazer = { 
      enable = true; 
      users = [ "${userCfg.name}" ];
      batteryNotifier = {
        enable = true;
        percentage = 33;
        frequency = 10000;
      }; 
    };

    home-manager.users."${userCfg.name}" = {
      home.packages = with pkgs; [ razergenie ];
    };
  };
}
