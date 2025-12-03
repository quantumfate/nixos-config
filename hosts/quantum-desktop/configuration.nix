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
      keyboard = "programmer-dvorak";
      monitors = [ "DP-1" "HDMI-A-1" ];
      primaryMonitor = "DP-1";
    };
    keyboard = {
      layout = "us";
      variant = "intl";
    };
    style = {
      fontFamily = "Inconsolata Nerd Font";
      borderRadius = 8;
    };
    modules = {
      nvidia.enable = true;
      dofus.enable = true;
      steam.enable = true;
      razer.enable = true;
    };
  };

}

