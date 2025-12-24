{ config, ... }:

let
  userCfg = config.common.user;
  primaryMonitor = config.common.peripherals.primaryMonitor;
  scriptDir = "/home/${userCfg.name}/.config/hypr/scripts";
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        "exec-once" = [
          "xrandr --output ${primaryMonitor.name} --primary --mode ${primaryMonitor.mode} --rate ${primaryMonitor.rate}"
          "hyprpanel"
          "${scriptDir}/wrapper/startup_special_workspaces.sh"
          "${scriptDir}/IPC/IPC_Wrapper.sh"
          "hyprlauncher -d"
          "proton-mail"
          "proton-pass"
        ];
      };
    };
  };
}
