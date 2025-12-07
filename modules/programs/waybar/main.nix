{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;

  modulesRight = {
    "quantum-desktop" = [
      "hyprland/language"
      "pulseaudio"
      "clock"
      "tray"
      "custom/mako"
      "custom/lock"
      "custom/reboot"
      "custom/power"
    ];
    "quantum-laptop" = [
      "hyprland/language"
      "pulseaudio"
      "clock"
      "tray"
      "custom/mako"
      "battery"
      "custom/lock"
      "custom/reboot"
      "custom/power"
    ];
    "default" = [
      "hyprland/language"
      "pulseaudio"
      "clock"
      "tray"
      "custom/mako"
      "custom/lock"
      "custom/reboot"
      "custom/power"
    ];
  };
in {
  home-manager.users."${userCfg.name}" = {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          include = "/home/${userCfg.name}/.config/waybar/modules";
          position = "top";
          height = 25;
          ipc = true;
          margin-top = 10;
          margin-right = 0;
          margin-left = 0;
          layer = "top";
          spacing = 0;
          fixed-center = true;
          output = [
            "${config.common.peripherals.primaryMonitor.name}"
          ]; # TODO: set a list of active monitors
          modules-left =
            [ "hyprland/workspaces" "cpu" "memory" "disk" "network" ];
          modules-center = [ "hyprland/window" ];
          modules-right = modulesRight.${hostName} or modulesRight.default;
        };
      };
    };
  };
}
