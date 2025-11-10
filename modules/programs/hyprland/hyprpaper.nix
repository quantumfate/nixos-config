{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
  wallpapersDir = "~/.config/hypr/wallpapers/";
in {
  home-manager.users."${userCfg.userName}" = {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = {
          "${wallpapersDir}Clearnight.jpg"
          "${wallpapersDir}Rainnight.jpg"
          "${wallpapersDir}shaded_landscape.png"
        };  
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
