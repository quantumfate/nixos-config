{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ../common.nix ../../modules ];

  common = {
    hostName = "quantum-laptop";
    user = {
      name = "quantum";
      shell = pkgs.zsh;
      groups = [ "video" "input" "ydotool" ];
      packages = [ pkgs.brightnessctl ];
    };
    peripherals = {
      monitors = [ "eDP-1" ];
      primaryMonitor = "eDP-1";
    };
    style = {
      fontFamily = "Inconsolata Nerd Font";
      borderRadius = 8;
    };
    modules = { bluetooth.enable = true; };
  };

}

