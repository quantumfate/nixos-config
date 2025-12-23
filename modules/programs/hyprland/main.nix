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
      hyprtoolkit
      hyprpaper
      hyprlauncher
      hypridle
      hyprpicker
      hyprlock
      hyprcursor
      hyprshot

      jq
      wl-clipboard
      socat
      inputs.grim-hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.hyprshutdown.packages.${pkgs.stdenv.hostPlatform.system}.default
      fzf
      chafa

      ydotool
      xdotool
      python313Packages.gpustat
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
          "BROWSER,zen-twilight"
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
          layout = "dwindle";
          snap = {
            enabled = true;
            monitor_gap = 30;
          };
        };

        decoration = {
          rounding = 8;

          active_opacity = 0.95;
          inactive_opacity = 0.85;

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
          sensitivity = 0.2;
        };
        dwindle = {
          pseudotile = true;
          preserve_split = true;
          force_split = 1;
        };

        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        master = { new_status = "master"; };
        group = {
          auto_group = true;
          groupbar = { enabled = true; };
        };

        cursor = { no_warps = true; };

        misc = {
          disable_hyprland_logo = true;
          font_family = "${config.common.style.guiFont}";
          splash_font_family = "${config.common.style.guiFont}";
          focus_on_activate = true;
          mouse_move_enables_dpms = true;
        };

        animations = {
          enabled = true;
          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
            "defout,0.16, 1, 0.3, 1"
            "overshot, 0.18, 0.95, 0.22, 1.03"
            "smoothOut, 0.5, 0, 0.99, 0.99"
            "smoothIn, 0.5, -0.5, 0.68, 1.5"
          ];
          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4, overshot, popin 60%"
            "windowsOut, 1, 1.1, linear, popin 70%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 4.5, defout, slidefade 15%"
            "specialWorkspaceIn, 1, 5, default, slidefadevert"
            "specialWorkspaceOut, 1, 5, defout, slidefadevert"
          ];
        };

        source = lib.lists.forEach [
          "alt-tab.conf"
          "named-windowrules.conf"
          "dofus-binds.conf"
        ] (conf: "/home/${userCfg.name}/.config/hypr/conf/" + conf);
      };
    };
  };
}
