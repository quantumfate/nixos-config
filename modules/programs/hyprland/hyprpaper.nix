{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
  userHome = config.users.users."${userCfg.userName}".home;
  wallpapersDir = "${userHome}/.config/hypr/wallpapers/";
in {
  home-manager.users."${userCfg.userName}" = {
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

    home.file.".config/hypr/scripts/" = {
      source = ./scripts;
      recursive = true;
    };
    home.file.".config/hypr/wallpapers/" = {
      source = ../../../assets/wallpapers;
      recursive = true;
    };
  };
}
