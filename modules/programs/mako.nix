{ config, pkgs, ... }:

let
  userCfg = config.common.user;
  catppuccin = config.theme.catppuccin;
  iconPath = "/run/current-system/sw/share/icons/hicolor";
in {

  home-manager.users."${userCfg.name}" = {

    catppuccin.mako.enable = false;
    stylix.targets.mako.enable = false;
    home.packages = with pkgs; [ libnotify ];

    services.mako = {
      enable = true;
      settings = {
        max-history = "8";
        font = "${config.common.style.fontFamily} 12";
        default-timeout = 0;
        background-color = "${catppuccin.rgba_hex.base 90}";
        text-color = "${catppuccin.hex.text}";
        width = 450;
        height = 150;
        outer-margin = "0,0,10,0";
        margin = 10;
        padding = 10;
        border-size = 3;
        border-color = "${catppuccin.hex.mauve}";
        border-radius = 8;
        # progress-color = "over ${catppuccin.rgba_hex.green 80}"; needs different bg and text color 
        # on notifications that need a progress color
        icons = 1;
        max-icon-size = 64;
        icon-path = "${iconPath}";
        icon-location = "left";
        output = "${config.common.peripherals.primaryMonitor.name}";
        layer = "top";
        anchor = "top-right";
        "urgency=low" = { border-color = "${catppuccin.hex.mauve}"; };
        "urgency=normal" = { border-color = "${catppuccin.hex.green}"; };
        "urgency=high" = {
          border-color = "${catppuccin.hex.red}";
          default-timeout = 0;
        };
        "app-name=Spotify" = {
          default-timeout = 3000;
          icon-border-radius = 8;
          icon-location = "right";
          anchor = "bottom-left";
          padding = "0,0,0,10";
          format = "<b>%s</b>\\n%b";
          on-button-left = "exec hyprctl dispatch focuswindow class:spotify";
        };
        "app-name=whatsapp-electron" = {
          default-timeout = 0;
          icon-border-radius = 8;
          icon-location = "right";
          anchor = "bottom-right";
          padding = "0,0,0,30";
          format = "<b>%s</b>\\n%b";
          on-button-left =
            "exec hyprctl dispatch focuswindow class:whatsapp-electron";
        };

        "app-name=pavucontrol" = {
          width = 100;
          default-timeout = 3000;
        };
        "app-name=brightnessctl" = {
          width = 200;
          default-timeout = 3000;
        };
        "app-name=\"Dofus Launch\"" = {
          width = 160;
          default-timeout = 3000;
          format = "<b>%a</b>\\n<b>%s</b>\\n%b";
          anchor = "top-left";
          text-alignment = "center";
        };
        "mode=do-not-disturb" = { invisible = 1; };
      };
    };
  };
}
