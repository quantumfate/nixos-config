{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        workspace = [
          "1,monitor:${config.common.peripherals.primaryMonitor}"
          "2,monitor:${config.common.peripherals.primaryMonitor}"
          "3,monitor:${config.common.peripherals.primaryMonitor}"
          "4,monitor:${config.common.peripherals.primaryMonitor}"
          "5,monitor:${config.common.peripherals.primaryMonitor}"
          "6,monitor:${config.common.peripherals.primaryMonitor}"
          "7,monitor:${config.common.peripherals.primaryMonitor}"
          "8,monitor:${config.common.peripherals.primaryMonitor}"
          "9,monitor:${config.common.peripherals.primaryMonitor}"
          "10,monitor:${config.common.peripherals.primaryMonitor}"
        ];
      };
    };
  };
}
