{ pkgs, config, inputs, ... }:

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
  borderActive = config.theme.catppuccin.rgba.teal 0.6;
  borderInActive = config.theme.catppuccin.rgba.maroon 0.6;
in {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
    xwayland.enable = true;
  };

  home-manager.users."${userCfg.name}" = {
    home.file.".config/hypr/scripts/" = {
      source = ./scripts;
      recursive = true;
    };
    home.file.".config/hypr/conf/" = {
      source = ./conf;
      recursive = true;
    };
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
      wl-clipboard
      
      inputs.grim-hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default
      fzf
      chafa
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
          "VISUAL,nvim"
          "PAGER,less"
          "QT_QPA_PLATFORMTHEME,hyprqt6engine"
          "QT_STYLE_OVERRIDE,kvantum"
          "XDG_CONFIG_HOME,$HOME/.config"
        ];

        monitor = monitorMaps.${hostName} or monitorMaps.default;
        general = {
          gaps_in = 5;
          gaps_out = 10;

          border_size = 2;

          "col.active_border" = "${borderActive}";
          "col.inactive_border" = "${borderInActive}";

          resize_on_border = false;

          allow_tearing = false;
          layout = "master";
          snap = {
            enabled = true;
          };
        };

        decoration = {
          rounding = 8;

          active_opacity = 0.95;
          inactive_opacity = 0.8;

          shadow = { enabled = false; };

          blur = { enabled = true; };
        };
        
        input = {
          kb_layout = "${config.common.keyboard.layout}";
          kb_variant = "${config.common.keyboard.variant}";
          follow_mouse = 0;
          mouse_refocus = true;
          touchpad = {
            disable_while_typing = true;
          };
        };

        group = {
          auto_group = true;
        };
        
        cursor = {
          no_warps = true;
        };

        misc = {
          disable_hyprland_logo = true;
          font_family = "${config.common.style.fontFamily}";
          splash_font_family = "${config.common.style.fontFamily}";
          focus_on_activate = true;
        };

        animations = { enabled = true; };
        source = [
          "/home/${userCfg.name}/.config/hypr/conf/alt-tab.conf"
        ];
      };
    };
  };
}

