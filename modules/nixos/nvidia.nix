{ config, lib, ... }:

let
  cfg = config.common.modules.nvidia;
in
{
  config = lib.mkIf cfg.enable {

    hardware.graphics.enable = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      # https://wiki.hypr.land/Nvidia/#suspendwakeup-issues
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = true; # Nvidia recommends open source drivers on GPUs that support it, https://download.nvidia.com/XFree86/Linux-x86_64/570.133.07/README/kernel_open.html
      nvidiaSettings = true;
    };
  };
}
