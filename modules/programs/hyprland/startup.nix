{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        "exec-once" = [
          "xrandr --output ${config.common.peripherals.primaryMonitor} --primary"
          "waybar"
          "hyprpaper"
          "discord"
          "spotify"
          "keepassxc"
        ];
      };
    };
  };
}
