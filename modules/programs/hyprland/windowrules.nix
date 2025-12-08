{ config, ... }:

let
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        windowrule = [
          "workspace 1, center on, match:class Ankama Launcher, match:title overlay"
          "workspace 1, center on, content game, fullscreen_state 0 0, decorate off, opacity 1.0 override, no_anim on, match:class Dofus.x64"
          "workspace 1, match:class code"
          "workspace 3, match:class steam"

          # Special Workspaces
          "workspace special:keepass, match:class org.keepassxc.KeePassXC"
          "workspace special:ankama, match:class Ankama Launcher, match:title Ankama Launcher"
          "workspace special:vesktop, match:class vesktop"
          "workspace special:spotify, match:class spotify"
          "workspace special:obs, match:initial_class com.obsproject.Studio"

          "match:class brave-browser, opacity 1.0 override"
          "float on, content photo, center on, dim_around on, size (window_w*0.85) (window_h*0.85), opacity 1.0 override, match:class feh"
        ];
        layerrule = [
          "match:namespace notifications, animation slide"
        ];
      };
    };
  };
}
