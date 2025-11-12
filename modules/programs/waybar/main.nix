{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common;
in {
  home-manager.users."${userCfg.userName}" = {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          include = "/home/${userCfg.userName}/.config/waybar/modules";
          position = "top";
          height = 25;
          ipc = true;
          margin-top = 10;
          margin-right = 0;
          margin-left = 0;
          layer = "top";
          spacing = 0;
          fixed-center = true;
          output = [ "DP-1" ]; # TODO: set a list of active monitors
          modules-left =
            [ "hyprland/workspaces" "cpu" "memory" "disk" "network" ];
          modules-center =
            [ "hyprland/window" ];
          modules-right =
            [ "hyprland/language" "pulseaudio" "clock" "tray" "custom/mako" "custom/lock" "custom/reboot" "custom/power" ];
        };
      };
    };
    home.file.".config/waybar/scripts/" = {
      source = ./scripts;
      recursive = true;
    };
  };
}
