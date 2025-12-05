{ config, ... }:

let
  userCfg = config.common.user;
  scriptDir = "/home/${userCfg.name}/.config/hypr/scripts/wrapper";
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        "$mainMod" = "SUPER";
        bind = [
          # Applications
          "$mainMod, return, exec, foot"
          "$mainMod, b, exec, brave"
          "$mainMod, f, exec, foot ranger"
          "$mainMod, X, exec, ${scriptDir}/minimize.sh"
          "$mainMod, d, exec, ${scriptDir}/dofus_toggle_launch.sh"

          "ALT, p, exec, hyprpicker -a -n"

          # Rofi
          "$mainMod, R, exec, rofi -show drun"
          "$mainMod ALT, R, exec, rofi -modi clipboard:/etc/profiles/per-user/${userCfg.name}/bin/cliphist-rofi -show clipboard"
          "$mainMod SHIFT, R, exec, rofi -modi clipboard:/etc/profiles/per-user/${userCfg.name}/bin/cliphist-rofi-img -show clipboard -show-icons"

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
          "$mainMod, PRINT, exec, ${scriptDir}/hyprshot.sh --window"
          " , PRINT, exec, ${scriptDir}/hyprshot.sh --output"
          "$mainMod SHIFT, PRINT, exec, ${scriptDir}/hyprshot.sh --region"

          ",F1, exec, ${scriptDir}/processFn.sh Rejecter"
          ",F2, exec, ${scriptDir}/processFn.sh Draintouch"
          ",F3, exec, ${scriptDir}/processFn.sh Reminiscer"
          ",F4, exec, ${scriptDir}/processFn.sh Traumafactory"
          ",F5, exec, ${scriptDir}/processFn.sh Memoryfracture"
          ",F6, exec, ${scriptDir}/processFn.sh Miserymaker"
          ",F7, exec, ${scriptDir}/processMButton.sh"

          # System
          "$mainMod ALT, l, exec, hyprlock"

          ",XF86AudioLowerVolume, exec, ${scriptDir}/volume.sh --dec"
          ",XF86AudioRaiseVolume, exec, ${scriptDir}/volume.sh --inc"
          ",XF86AudioMute, exec, ${scriptDir}/volume.sh --toggle"
          ",XF86AudioMicMute, exec, ${scriptDir}/volume.sh --toggle-mic"

          ",XF86MonBrightnessDown, exec, ${scriptDir}/brightness.sh --dec"
          ",XF86MonBrightnessUp, exec, ${scriptDir}/brightness.sh --inc"
        ]; # ++ userCfg.lib.hyprland.generateKeybinding { };

      };
    };
  };
}

