{ config, ... }:

let
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        windowrule = [
          "workspace 1, center on, match:class Ankama Launcher, match:title overlay"
          "workspace 1, center on, content game, decorate off, opacity 1.0 override, no_anim on, match:class Dofus.x64"
          "workspace 1, match:class code"

          "workspace 2, match:class brave-browser, opacity 1.0 override"

          "workspace 3, match:class steam"

          "workspace 4 silent, match:class spotify"
          "workspace 4 silent, match:class vesktop"

          # Special Workspaces
          "workspace special:keepass, match:class org.keepassxc.KeePassXC"
          "workspace special:ankama-launcher, match:class Ankama Launcher, match:title Ankama Launcher"

          "float on, content photo, center on, size (window_w*0.85) (window_h*0.85), opacity 1.0 override, match:class feh"
        ];
      };
    };
  };
}
