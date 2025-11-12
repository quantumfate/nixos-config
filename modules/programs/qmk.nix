{ config, lib, pkgs, ... }:

let userCfg = config.common;
{
  home-manager.users.${userCfg.userName} = {
    home.packages = with pkgs; [
      qmk
      qmk-udev-rules
      via
    ];
  };
  hardware.keyboard.qmk.enable = true;
  services.udev.packages = [ pkgs.via ];
}