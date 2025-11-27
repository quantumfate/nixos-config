{ pkgs, config, inputs, lib, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;

  monitorMaps = {
    "quantum-desktop" = [
      "DP-1, 2560x1440@144, 0x0, 1"
      # TODO: potentially think about this https://wiki.hypr.land/Configuring/Monitors/#custom-reserved-area
      "HDMI-A-1, 800x1280@60, 2560x0, 1, transform, 1"
    ];
    "quantum-laptop" = [ "eDP-1, 1920x1080@60, auto, 1" ];
    "default" = [ ", preferred, auto, 1" ];
  };

  removeSpaces = s: lib.strings.replaceStrings [ " " ] [ "" ] s;
  rgbToRgba = rgbString: alpha:
    let
      rgbaStart = lib.strings.replaceStrings [ "rgb(" ] [ "rgba(" ] rgbString;
      content = lib.strings.substring 4 (lib.strings.stringLength rgbString - 5)
        rgbString;
    in removeSpaces "rgba(${content},${toString alpha})";

  borderActive = rgbToRgba colors.teal.rgb 0.6;
  borderInActive = rgbToRgba colors.maroon.rgb 0.6;

  colors = config.colors.catppuccin.mocha;
in {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };

  home-manager.users."${userCfg.name}" = {
    xdg.desktopEntries."hyprland" = {
      type = "Application";
      name = "Hyprland";
      exec = "Hyprland";
      comment =
        "Hyprland is an independent, highly customizable, dynamic tiling Wayland compositor that doesn't sacrifice on its looks.";
    };
    home.packages = with pkgs; [
      hyprpaper
      hypridle
      hyprpicker
      hyprlock
      hyprcursor
      hyprshot
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      # https://wiki.hypr.land/Nix/Hyprland-on-Home-Manager/#using-the-home-manager-module-with-nixos
      package = null;
      portalPackage = null;
      settings = {
        env = [
          "NIXOS_OZONE_WL,1"
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "QT_QPA_PLATFORM,wayland"
          "XDG_PICTURES_DIR,$HOME/Pictures"
          "XDG_SCREENSHOTS_DIR,$HOME/Pictures/screens"
          "HYPRSHOT_DIR,$HOME/Pictures/screens"
          "EDITOR,nvim"
          "QT_QPA_PLATFORMTHEME,hyprqt6engine"
          "XDG_CONFIG_HOME,$HOME/.config"
        ];

        monitor = monitorMaps.${hostName} or monitorMaps.default;
        general = {
          gaps_in = 5;
          gaps_out = 10;

          border_size = 2;

          "col.active_border" = "${borderActive}";
          "col.inactive_border" = "${borderInActive}";

          resize_on_border = true;

          allow_tearing = false;
          layout = "master";
        };

        decoration = {
          rounding = 8;

          active_opacity = 0.95;
          inactive_opacity = 0.8;

          shadow = { enabled = false; };

          blur = { enabled = true; };
        };

        animations = { enabled = true; };
        plugin = { xwaylandprimary = { display = "DP-1"; }; };
      };
    };
  };
}

