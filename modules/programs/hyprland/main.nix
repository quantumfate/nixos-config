{ pkgs, config, ... }:

let
  hostName = config.networking.hostName;
  mainUser = config.mainUser;

  monitorMaps = {
    "quantum-desktop" = [
      "DP-1, 2560x1440@144, 0x0, 1"
      # TODO: potentially think about this https://wiki.hypr.land/Configuring/Monitors/#custom-reserved-area
      "HDMI-A-1, 800x1280@60, 2560x0, 1, transform, 1"
    ];
    "quantum-laptop" = [ "eDP-1, 1920x1080@60, auto, 1" ];
    "default" = [ ", preferred, auto, 1" ];
  };
in {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };

  home-manager.users."${mainUser}" = {
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
          gaps_in = 0;
          gaps_out = 0;

          border_size = 1;

          "col.active_border" = "rgb(${config.colorScheme.palette.base01})";
          "col.inactive_border" = "rgb(${config.colorScheme.palette.base00})";

          resize_on_border = true;

          allow_tearing = false;
          layout = "master";
        };

        decoration = {
          rounding = 0;

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

