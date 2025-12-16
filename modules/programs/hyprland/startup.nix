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
          "sleep 2; spotify"
          "sleep 2; keepassxc"
          "sleep 2; vesktop"
          "sleep 2; whatsapp-electron"
          "${scriptDir}/IPC_Wrapper.sh"
        ];
      };
    };
  };
}
