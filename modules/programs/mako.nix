{ config, lib, pkgs, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
  colors = config.colors.catppuccin.mocha;
in {

  home-manager.users."${userCfg.userName}" = {

    home.packages = with pkgs; [ libnotify ];

    services.mako = {
      enable = true;
      settings = {
        # Global Options
        max-history = "8";
        # Style options
        font = "Inconsolata Nerd Font 10";
        default-timeout = 0;
        background-color = "${colors.base.hex}";
        text-color = "${colors.text.hex}";
        width = 300;
        height = 100;
        outer-margin = 0;
        margin = 10;
        padding = 10;
        border-size = 2;
        border-color = "${colors.teal.hex}";
        border-radius = 8;
        progress-color = "${colors.mauve.hex}";
        icons = 1;
        max-icon-size = 64;
        icon-path = "/run/current-system/sw/share/icons/hicolor";
        icon-location = "left";
        output= "DP-1";
        layer = "top";
        anchor = "top-right";
        "urgency=low" = { border-color = "${colors.green.hex}"; };
        "urgency=normal" = { border-color = "${colors.yellow.hex}"; };
        "urgency=high" = {
          border-color = "${colors.red.hex}";
          default-timeout = 0;
        };
        "app-name=Spotify" = {
          default-timeout = 3000;
          anchor = "top-center";
        };
        "app-name=pavucontrol" = {
          width = 80;
          default-timeout = 3000;
        };
        "mode=do-not-disturb" = {
          invisible = 1;
        };
      };
    };
  };
}
