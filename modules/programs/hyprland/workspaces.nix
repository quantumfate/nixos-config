{ config, ... }:

let
  userCfg = config.common.user;
  primaryMonitor = config.common.peripherals.primaryMonitor;
  scriptDir = "/home/${userCfg.name}/.config/hypr/scripts/wrapper";
in {
  home-manager.users."${userCfg.name}" = {
    wayland.windowManager.hyprland = {
      settings = {
        workspace = [
          "1,monitor:${primaryMonitor.name}, default:true"
          "2,monitor:${primaryMonitor.name}"
          "3,monitor:${primaryMonitor.name}"
          "4,monitor:${primaryMonitor.name}"
          "5,monitor:${primaryMonitor.name}"
          "6,monitor:${primaryMonitor.name}"
          "7,monitor:${primaryMonitor.name}"
          "8,monitor:${primaryMonitor.name}"
          "9,monitor:${primaryMonitor.name}"
          "10,monitor:${primaryMonitor.name}"
          "s[true]m[${primaryMonitor.name}]n[e:gaming], name:gaming, on-created-empty:steam"
          "s[true]m[${primaryMonitor.name}]n[e:keepass], name:keepass, on-created-empty:keepassxc"
          "s[true]m[${primaryMonitor.name}]n[e:ankama], name:ankama, on-created-empty:ankama-launcher"
          "s[true]m[${primaryMonitor.name}]n[e:dofus], name:dofus, on-created-empty:hyprctl --batch \"dispatch exec zen-twilight -P dofus\""
          "s[true]m[${primaryMonitor.name}]n[e:vesktop], name:vesktop, on-created-empty:vesktop"
          "s[true]m[${primaryMonitor.name}]n[e:spotify], name:spotiy, on-created-empty:spotify"
          "s[true]m[${primaryMonitor.name}]n[e:obs], name:obs, on-created-empty:${scriptDir}/on_created_empty.sh obs"
          "s[true]m[${primaryMonitor.name}]n[e:whatsapp-electron], name:whatsapp, on-created-empty:${scriptDir}/on_created_empty.sh whatsapp-electron"
        ];
      };
    };
  };
}
