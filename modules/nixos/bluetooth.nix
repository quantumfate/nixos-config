{ config, lib, ... }:

let
  cfg = config.common.modules.bluetooth;
  userCfg = config.common.user;
in {
  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
        Policy = { AutoEnable = true; };
      };
    };
    services.blueman.enable = true;

    home-manager.users."${userCfg.name}" = {
      services.blueman-applet.enable = true;
    };
  };
}
