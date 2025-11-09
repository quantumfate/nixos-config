{ pkgs, config, inputs, lib, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.mainUser;

  monitorMaps = {
    "quantum-desktop" = [
      "DP-1, 2560x1440@144, 0x0, 1"
      # TODO: potentially think about this https://wiki.hypr.land/Configuring/Monitors/#custom-reserved-area
      "HDMI-A-1, 800x1280@60, 2560x0, 1, transform, 1"
    ];
    "quantum-laptop" = [ "eDP-1, 1920x1080@60, auto, 1" ];
    "default" = [ ", preferred, auto, 1" ];
  };
  
  removeHash = s: lib.strings.replaceStrings [ "#" ] [ "" ] s;
  colors = config.colors.catppuccin.mocha;
in {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };

  home-manager.users."${userCfg.userName}" = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      settings = {
        env = [
          "NIXOS_OZONE_WL,1"
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "QT_QPA_PLATFORM,wayland"
          "XDG_SCREENSHOTS_DIR,$HOME/screens"
          "EDITOR,nvim"
        ];

        monitor = monitorMaps.${hostName} or monitorMaps.default;
        general = {
          gaps_in = 5;
          gaps_out = 10;

          border_size = 2;

          "col.active_border" = "rgb(${removeHash colors.teal.hex})";
          "col.inactive_border" = "rgb(${removeHash colors.maroon.hex})";

          resize_on_border = true;

          allow_tearing = false;
          layout = "master";
        };

        decoration = {
          rounding = 2;

          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = { enabled = false; };

          blur = { enabled = false; };
        };

        animations = { enabled = true; };
      };
    };
  };
}

