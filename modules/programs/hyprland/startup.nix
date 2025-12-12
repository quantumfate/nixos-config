{ config, ... }:

let
  userCfg = config.common.user;
  primaryMonitor = config.common.peripherals.primaryMonitor;
  scriptDir = "/home/${userCfg.name}/.config/hypr/scripts/IPC";
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        "exec-once" = [
          "xrandr --output ${primaryMonitor.name} --primary --mode ${primaryMonitor.mode} --rate ${primaryMonitor.rate}"
          "waybar"
          #"${scriptDir}/IPC_Wrapper.sh"
        ];
      };
    };
  };
}
