{ config, ... }:

let
  userCfg = config.common.user;
  primaryMonitor = config.common.peripherals.primaryMonitor;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        "exec-once" = [
          "xrandr --output ${primaryMonitor.name} --primary --mode ${primaryMonitor.mode} --rate ${primaryMonitor.rate}"
          "waybar"
        ];
      };
    };
  };
}
