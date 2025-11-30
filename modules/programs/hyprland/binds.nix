{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        "$mainMod" = "SUPER";
        bind = [
          "$mainMod, T, exec, foot"
          "$mainMod, F, exec, chromium"
          "$mainMod, R, exec, rofi -show run"
          "$mainMod, X, exec, /home/${userCfg.name}/.config/hypr/scripts/minimize.sh"
          "$mainMod SHIFT, c, exec, hyprlock"
          "$mainMod, d, exec, pkill -SIGINT dofuslaunch.sh || /home/${userCfg.name}/.config/hypr/scripts/dofuslaunch.sh"

          # Switching workspaces
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Send window to workspaces
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # Moving focus
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, j, movefocus, u"
          "$mainMod, k, movefocus, d"

          # Moving windows
          "$mainMod SHIFT, h,  swapwindow, l"
          "$mainMod SHIFT, l, swapwindow, r"
          "$mainMod SHIFT, j,    swapwindow, u"
          "$mainMod SHIFT, k,  swapwindow, d"

          # Resizeing windows                   X  Y
          "$mainMod CTRL, h,  resizeactive, -10 0"
          "$mainMod CTRL, l, resizeactive,  10 0"
          "$mainMod CTRL, j,    resizeactive,  0 -10"
          "$mainMod CTRL, k,  resizeactive,  0  10"

          # Screenshots
          "$mainMod, PRINT, exec, hyprshot -m window"
          " , PRINT, exec, hyprshot -m output"
          "$mainMod SHIFT, PRINT, exec, hyprshot -m region"

          ",F1, alterzorder, top, title:Dofus Miserymaker"
          ",F1, focuswindow, title:Dofus Miserymaker"
          ",F2, alterzorder, top, title:Dofus Rejecter"
          ",F2, focuswindow, title:Dofus Rejecter"
        ]; # ++ userCfg.lib.hyprland.generateKeybindings { };

      };
    };
  };
}

