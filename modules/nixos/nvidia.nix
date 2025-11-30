{ config, lib, pkgs, ... }:

let cfg = config.common.modules.nvidia;
in {
  config = lib.mkIf cfg.enable {

    hardware.graphics.enable = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
    };
  };
}
