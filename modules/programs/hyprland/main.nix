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
  borderActive = config.theme.catppuccin.rgba.mauve 0.8;
  borderInActive = config.theme.catppuccin.rgba.base 0.8;
in {
  programs.hyprland = {
    enable = true;
    package =
      inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
    xwayland.enable = true;
  };

  home-manager.users."${userCfg.name}" = {
    home.file.".config/hypr/scripts/" = {
      source = ./scripts;
      executable = true;
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
      hyprshutdown

      jq
      wl-clipboard
      socat
      inputs.grim-hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default
      fzf
      chafa

      ydotool
      xdotool
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
          "GSK_RENDERER,gl"
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
            monitor_gap = 30;
          };
        };

        decoration = {
          rounding = 8;

          active_opacity = 0.88;
          inactive_opacity = 0.88;
          
          dim_special = 0.4;
          dim_around = 0.6;

          shadow = {
            enabled = true;
            range = 2;
          };

          blur = { 
            enabled = true; 
            size = 12;
            passes = 2;
            new_optimizations = true;
            ignore_opacity = true;
          };
        };

        input = {
          kb_layout = "us";
          kb_variant = "dvp";

          follow_mouse = 0;
          mouse_refocus = false;
          touchpad = { disable_while_typing = true; };
        };

        group = {
          auto_group = true;
          groupbar = { enabled = true; };
        };

        cursor = { no_warps = true; };

        misc = {
          disable_hyprland_logo = true;
          font_family = "${config.common.style.fontFamily}";
          splash_font_family = "${config.common.style.fontFamily}";
          focus_on_activate = true;
          mouse_move_enables_dpms = true;
        };

        animations = { enabled = true; };

        binds = {
          workspace_back_and_forth = true;

        };
        source = [ "/home/${userCfg.name}/.config/hypr/conf/alt-tab.conf" ];
      };
    };
  };
}
