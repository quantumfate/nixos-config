{ config, ... }:

let
  userCfg = config.common.user;
  userHome = config.users.users."${userCfg.name}".home;
  wallpapersDir = "${userHome}/.config/hypr/wallpapers/";
in
{
  home-manager.users."${userCfg.name}" = {
    services.hyprpaper = {
      enable = true;
    };

    home.file = {
      ".config/hypr/wallpapers/" = {
        source = ../../../../assets/wallpapers;
        recursive = true;
      };
      ".config/hypr/hyprpaper.conf" = {
        text = ''
          wallpaper {
            monitor =
            path = ~/.config/hypr/wallpapers/anime-girl.jpg
            fit_mode = cover
          }
        '';
      };
    };

  };
}
