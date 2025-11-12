{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common;
in {
  home-manager.users."${userCfg.userName}" = {
    wayland.windowManager.hyprland = {
      settings = {
        "$mainMod" = "SUPER";
        bind = [
          "$mainMod, T, exec, alacritty"
          "$mainMod, F, exec, brave"
          "$mainMod, R, exec, rofi -show run"
          "$mainMod, X, killactive"

          # Moving focus
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Moving windows
          "$mainMod SHIFT, left,  swapwindow, l"
          "$mainMod SHIFT, right, swapwindow, r"
          "$mainMod SHIFT, up,    swapwindow, u"
          "$mainMod SHIFT, down,  swapwindow, d"

          # Resizeing windows                   X  Y
          "$mainMod CTRL, left,  resizeactive, -60 0"
          "$mainMod CTRL, right, resizeactive,  60 0"
          "$mainMod CTRL, up,    resizeactive,  0 -60"
          "$mainMod CTRL, down,  resizeactive,  0  60"

          # Screenshots
          "$mainMod, PRINT, exec, hyprshot -m window"
          " , PRINT, exec, hyprshot -m output"
          "$mainMod SHIFT, PRINT, exec, hyprshot -m region"
        ] ++ userCfg.lib.hyprland.generateKeybindings { };

        bindm =
          [ "ALT, mouse:272, movewindow" "$mainMod, mouse:273, resizewindow" ];
      };
    };
  };
}

