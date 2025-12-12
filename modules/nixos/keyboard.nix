{ config, pkgs, lib, ... }:

{
  config = {
    environment.systemPackages = with pkgs;
      [ ] ++ lib.optionals config.common.modules.qmk.enable [ qmk dos2unix ];
    hardware.keyboard.qmk.enable = config.common.modules.qmk.enable;

    console = {
      useXkbConfig = true; # use xkbOptions in tty.
    };

    services.xserver = {
      xkb.layout = "us";
      xkb.variant = "dvp";
    };
  };
}
