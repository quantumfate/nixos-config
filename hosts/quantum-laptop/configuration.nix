{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ../common.nix ../../modules ];

  common = {
    hostName = "quantum-laptop";
    user = {
      name = "quantum";
      shell = pkgs.zsh;
    };
    peripherals = {
      keyboard = "programmer-dvorak";
      monitors = [ "eDP-1" ];
      primaryMonitor = "eDP-1";
    };
    keyboard = {
      layout = "dvorak";
      variant = "intl";
    };
    style = {
      fontFamily = "Inconsolata Nerd Font";
      borderRadius = 8;
    };
  };

}

