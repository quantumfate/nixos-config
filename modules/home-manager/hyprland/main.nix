{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      env = [
        # Hint Electron apps to use Wayland
        "NIXOS_OZONE_WL,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,$HOME/screens"
        "EDITOR,nvim"
      ];
      
      # TODO: host based monitor layout
      monitor = [
        "DP-1, 2560x1440@144, 0x0, 1"
        "HDMI-A-1, 800x1280@60, 2560x0, 1, transform, 1"
      ];
      general = {
        gaps_in = 0;
        gaps_out = 0;

        border_size = 5;

        "col.active_border" = "rgba(d65d0eff) rgba(98971aff) 45deg";
        "col.inactive_border" = "rgba(3c3836ff)";

        resize_on_border = true;

        allow_tearing = false;
        layout = "master";
      };

      decoration = {
        rounding = 0;

        active_opacity = 1.0;
        inactive_opacity = 0.8;

        shadow = { enabled = false; };

        blur = { enabled = false; };
      };

      animations = { enabled = true; };
    };
  };
}

