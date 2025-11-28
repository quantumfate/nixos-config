{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
  userHome = config.users.users."${userCfg.name}".home;
  wallpapersDir = "${userHome}/.config/hypr/wallpapers/";
in {
  home-manager.users."${userCfg.name}" = {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "${wallpapersDir}Clearnight.jpg"
          "${wallpapersDir}Rainnight.jpg"
          "${wallpapersDir}purple-forest.jpg"
          "${wallpapersDir}anime-girl.jpg"
        ];
        wallpaper = [ 
          ",${wallpapersDir}anime-girl.jpg" 
        ];
      };
    };

    home.file.".config/hypr/wallpapers/" = {
      source = ../../../assets/wallpapers;
      recursive = true;
    };
  };
}
