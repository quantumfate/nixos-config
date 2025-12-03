{ config, pkgs, ... }:

let
  userCfg = config.common.user;
  catppuccin = config.theme.catppuccin;
in {

  home-manager.users."${userCfg.name}" = {

    home.packages = with pkgs; [ libnotify ];

    services.mako = {
      enable = true;
      settings = {
        max-history = "8";
        font = "Inconsolata Nerd Font 10";
        default-timeout = 0;
        background-color = "${catppuccin.hex.base}";
        text-color = "${catppuccin.hex.text}";
        width = 300;
        height = 100;
        outer-margin = "0,0,10,0";
        margin = 10;
        padding = 10;
        border-size = 2;
        border-color = "${catppuccin.hex.mauve}";
        border-radius = 8;
        progress-color = "${catppuccin.hex.mauve}";
        icons = 1;
        max-icon-size = 64;
        icon-path = "/run/current-system/sw/share/icons/hicolor";
        icon-location = "left";
        output= "${config.common.peripherals.primaryMonitor}";
        layer = "top";
        anchor = "top-right";
        "urgency=low" = { border-color = "${catppuccin.hex.teal}"; };
        "urgency=normal" = { border-color = "${catppuccin.hex.yellow}"; };
        "urgency=high" = {
          border-color = "${catppuccin.hex.red}";
          default-timeout = 0;
        };
        "app-name=Spotify" = {
          default-timeout = 3000;
          anchor = "bottom-left";
        };
        "app-name=pavucontrol" = {
          width = 80;
          default-timeout = 3000;
        };
        "app-name=brightnessctl" = {
          width = 150;
          default-timeout = 3000;
        };
        "app-name=\"Dofus Launch\"" = {
          width = 150;
          default-timeout = 3000;
          format = "<b>%a</b>\\n<b>%s</b>\\n%b";
          anchor = "top-left";
          text-alignment = "center";
        };
        "mode=do-not-disturb" = {
          invisible = 1;
        };
      };
    };
  };
}
