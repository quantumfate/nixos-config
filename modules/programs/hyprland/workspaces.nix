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
          "s[true]m[${config.common.peripherals.primaryMonitor}]n[e:keepass], name:keepass, on-created-empty:keepassxc"
          "s[true]m[${config.common.peripherals.primaryMonitor}]n[e:ankama], name:ankama, on-created-empty:ankama-launcher"
          "s[true]m[${config.common.peripherals.primaryMonitor}]n[e:dofus], name:dofus, on-created-empty:hyprctl --batch \"dispatch exec brave --new-window https://www.dofuspourlesnoobs.com/ https://dofusdb.fr/en/ https://dofensive.com/en https://www.dofusbook.net/en/\""
          "s[true]m[${config.common.peripherals.primaryMonitor}]n[e:vesktop], name:vesktop, on-created-empty:vesktop"
          "s[true]m[${config.common.peripherals.primaryMonitor}]n[e:spotify], name:spotiy, on-created-empty:spotify"
        ];
      };
    };
  };
}
