{ config, ... }:

let
  userCfg = config.common.user;
  scriptDir = "/home/${userCfg.name}/.config/hypr/scripts/wrapper";

  # https://github.com/xkbcommon/libxkbcommon/blob/master/include/xkbcommon/xkbcommon-keysyms.h
  # https://wiki.hypr.land/Configuring/Binds/#uncommon-syms--binding-with-a-keycode
  programmerDvorakMap = {
    "1" = "ampersand"; # &
    "2" = "bracketleft"; # [
    "3" = "braceleft"; # {
    "4" = "braceright"; # }
    "5" = "parentleft"; # (
    "6" = "equal"; # =
    "7" = "asterisk"; # *
    "8" = "parentright"; # )
    "9" = "plus"; # +
    "0" = "bracketright"; # ]
  };
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        "$mainMod" = "SUPER";
        bindd = [
          "$mainMod, TAB, Previous workspace, workspace, e-1"
          "$mainMod SHIFT, TAB, Previous workspace, workspace, e+1"

          "$mainMod, S, Toggle split, togglesplit, # dwindle"
          "$mainMod, P, Pseudo window, pseudo, # dwindle"

          # Switching workspaces
          "$mainMod, ${
            programmerDvorakMap."1"
          }, Switch to workspace 1, workspace, 1"
          "$mainMod, ${
            programmerDvorakMap."2"
          }, Switch to workspace 2, workspace, 2"
          "$mainMod, ${
            programmerDvorakMap."3"
          }, Switch to workspace 3, workspace, 3"
          "$mainMod, ${
            programmerDvorakMap."4"
          }, Switch to workspace 4, workspace, 4"
          "$mainMod, ${
            programmerDvorakMap."5"
          }, Switch to workspace 5, workspace, 5"
          "$mainMod, ${
            programmerDvorakMap."6"
          }, Switch to workspace 6, workspace, 6"
          "$mainMod, ${
            programmerDvorakMap."7"
          }, Switch to workspace 7, workspace, 7"
          "$mainMod, ${
            programmerDvorakMap."8"
          }, Switch to workspace 8, workspace, 8"
          "$mainMod, ${
            programmerDvorakMap."9"
          }, Switch to workspace 9, workspace, 9"
          "$mainMod, ${
            programmerDvorakMap."0"
          }, Switch to workspace 10, workspace, 10"

          # Send window to workspaces
          "$mainMod SHIFT, ${
            programmerDvorakMap."1"
          },Switch to workspace 1, movetoworkspace, 1"
          "$mainMod SHIFT, ${
            programmerDvorakMap."2"
          },Switch to workspace 2, movetoworkspace, 2"
          "$mainMod SHIFT, ${
            programmerDvorakMap."3"
          },Switch to workspace 3, movetoworkspace, 3"
          "$mainMod SHIFT, ${
            programmerDvorakMap."4"
          },Switch to workspace 4, movetoworkspace, 4"
          "$mainMod SHIFT, ${
            programmerDvorakMap."5"
          },Switch to workspace 5, movetoworkspace, 5"
          "$mainMod SHIFT, ${
            programmerDvorakMap."6"
          },Switch to workspace 6, movetoworkspace, 6"
          "$mainMod SHIFT, ${
            programmerDvorakMap."7"
          },Switch to workspace 7, movetoworkspace, 7"
          "$mainMod SHIFT, ${
            programmerDvorakMap."8"
          },Switch to workspace 8, movetoworkspace, 8"
          "$mainMod SHIFT, ${
            programmerDvorakMap."9"
          },Switch to workspace 9, movetoworkspace, 9"
          "$mainMod SHIFT, ${
            programmerDvorakMap."0"
          },Switch to workspace 10,movetoworkspace, 10"
        ];
        bind = [
          # Applications
          "$mainMod, return, exec, foot"
          "$mainMod, b, exec, zen-twilight"
          "$mainMod, f, exec, foot ranger"
          "$mainMod, q, exec, ${scriptDir}/minimize.sh"

          "ALT, p, exec, hyprpicker -a -n"
          "$mainMod, s, exec, btop"

          # Rofi
          "$mainMod, R, exec, rofi -show drun"
          "$mainMod ALT, R, exec, rofi -modi clipboard:/etc/profiles/per-user/${userCfg.name}/bin/cliphist-rofi -show clipboard"
          "$mainMod SHIFT, R, exec, rofi -modi clipboard:/etc/profiles/per-user/${userCfg.name}/bin/cliphist-rofi-img -show clipboard -show-icons"

          # Special workspaces
          "$mainMod ALT, k, togglespecialworkspace, keepass"
          "$mainMod ALT, a, togglespecialworkspace, ankama"
          "$mainMod ALT, d, togglespecialworkspace, dofus"
          "$mainMod ALT, v, togglespecialworkspace, vesktop"
          "$mainMod ALT, s, togglespecialworkspace, spotify"
          "$mainMod ALT, o, togglespecialworkspace, obs"
          "$mainMod ALT, w, togglespecialworkspace, whatsapp-electron"

          # Moving focus
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, j, movefocus, u"
          "$mainMod, k, movefocus, d"

          # Moving windows
          "$mainMod SHIFT, h, swapwindow, l"
          "$mainMod SHIFT, l, swapwindow, r"
          "$mainMod SHIFT, j, swapwindow, u"
          "$mainMod SHIFT, k, swapwindow, d"

          # Resizeing windows
          "$mainMod CTRL, h, resizeactive, -10 0"
          "$mainMod CTRL, l, resizeactive,  10 0"
          "$mainMod CTRL, j, resizeactive,  0 -10"
          "$mainMod CTRL, k, resizeactive,  0  10"

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
          ",F7, exec, ${scriptDir}/processFn.sh Aiizen-Sosuke"
          ",F8, exec, ${scriptDir}/processFn.sh Yoruiichii-Shihoin"
          ",mouse:274, exec, ${scriptDir}/processMButton.sh"

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

