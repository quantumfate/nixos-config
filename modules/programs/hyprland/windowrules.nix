{ config, ... }:

let
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        windowrule = [
          "workspace 3 silent, match:class spotify"
          "workspace 3 silent, match:class discord"
          "workspace 4 silent, match:class org.keepassxc.KeePassXC"
          "workspace 5, match:class steam"
          "workspace 5, match:class Ankama Launcher"
          "workspace 6, center on, content game, decorate off, no_anim on, match:class Dofus.x64"
        ];
      };
    };
  };
}
