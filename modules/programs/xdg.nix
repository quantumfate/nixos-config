{ config, pkgs, lib, inputs, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common;
in {

  home-manager.users."${userCfg.userName}" = {
    xdg = {
      enable = true;
      mime.enable = true;
      portal = {
        enable = true;
        configPackages = [
          inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
        ];
        extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

        config = { "hyprland" = { default = [ "hyprland" ]; }; };
      };
    };
  };
}
