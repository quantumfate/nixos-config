{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ../common.nix ];

  common = {
    hostName = "quantum-desktop";
    user = {
      name = "quantum";
      shell = pkgs.zsh;
      groups = [ "ydotool" ];
    };
    peripherals = {
      monitors = [ "DP-1" "HDMI-A-1" ];
      primaryMonitor = {
        name = "DP-1";
        mode = "2560x1440";
        rate = "144";
      };
    };
    style = {
      fontFamily = "Inconsolata Nerd Font";
      borderRadius = 8;
    };
    modules = {
      nvidia.enable = true;
      dofus.enable = true;
      steam.enable = true;
    };
  };

}

