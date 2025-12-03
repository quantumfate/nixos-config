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
    
    services.input-remapper = {
      enable = true;
      enableUdevRules = true;
      package = pkgs.input-remapper;
    };

    home-manager.users."${userCfg.name}" = {
      home.packages = with pkgs; [ razergenie input-remapper ];
    };
  };
}
