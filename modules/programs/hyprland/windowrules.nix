{ config, ... }:

let
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        windowrule = [
          "workspace 3 silent, match:class spotify"
          "workspace 3 silent, match:class vesktop"
          "workspace 4 silent, match:class org.keepassxc.KeePassXC"
          "workspace 5, match:class steam"
          "workspace 5, center on, match:class Ankama Launcher, match:title overlay"
          "workspace 5, match:class Ankama Launcher, match:title Ankama Launcher"
          "workspace 6, center on, content game, decorate off, opacity 1.0 override, no_anim on, match:class Dofus.x64"
          "float on, content photo, center on, size (window_w*0.85) (window_h*0.85), opacity 1.0 override, match:class feh"

          # Brave
          "match:class brave-browser, opacity 1.0 override"
        ];
      };
    };
  };
}
