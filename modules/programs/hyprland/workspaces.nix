{ config, ... }:

let
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        workspace = [
          "1,monitor:${config.common.peripherals.primaryMonitor}, default:true"
          "2,monitor:${config.common.peripherals.primaryMonitor}"
          "3,monitor:${config.common.peripherals.primaryMonitor}"
          "4,monitor:${config.common.peripherals.primaryMonitor}"
          "5,monitor:${config.common.peripherals.primaryMonitor}"
          "6,monitor:${config.common.peripherals.primaryMonitor}"
          "7,monitor:${config.common.peripherals.primaryMonitor}"
          "8,monitor:${config.common.peripherals.primaryMonitor}"
          "9,monitor:${config.common.peripherals.primaryMonitor}"
          "10,monitor:${config.common.peripherals.primaryMonitor}"
          "s[true]m[${config.common.peripherals.primaryMonitor}], name:keepass, on-created-empty:keepassxc"
          "s[true]m[${config.common.peripherals.primaryMonitor}], name:ankama, on-created-empty:ankama-launcher"
        ];
      };
    };
  };
}
