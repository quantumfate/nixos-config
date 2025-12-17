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
      primaryMonitor = {
        name = "eDP-1";
        mode = "1920x1080";
        rate = "60";
      };
    };
    style = {
      guiFont = "DejaVuSansM Nerd Font";
      terminalFont = "Inconsolata Nerd Font";
      borderRadius = 8;
    };
    modules = { bluetooth.enable = true; };
  };

}

