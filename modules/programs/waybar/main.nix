{ config, ... }:

let
  hostName = config.networking.hostName;
  mainUser = config.mainUser;
in {
  home-manager.users."${mainUser}" = {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          include = "/home/${mainUser}/.config/waybar/modules";
          position = "top";
          height = 35;
          ipc = true;
          margin-right = 0;
          margin-left = 0;
          layer = "top";
          spacing = 6;
          fixed-center = true;
          output =  [ "DP-1" ]; # TODO: set a list of active monitors
          modules-left =
            [ "hyprland/workspaces" "cpu" "memory" "disk" "network" ];
          modules-center =
            [ "hyprland/window" "custom/spotify" "custom/weather" ];
          modules-right =
            [ "hyprland/language" "pulseaudio" "clock" "tray" "custom/dunst" ];
        };
      };
    };
    home.file.".config/waybar/scripts/" = {
      source = ./scripts;
      recursive = true;
    };
  };
}
