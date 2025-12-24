{ config, ... }:

let userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    # Fix not starting on wayland
    xdg.desktopEntries."proton-authenticator" = {
      type = "Application";
      name = "Proton Authenticator";
      icon = "proton-authenticator";
      exec = "env WEBKIT_DISABLE_COMPOSITING_MODE=1 proton-authenticator";
      comment = "Proton Authenticator";
      categories = [ "Utility" ];
      terminal = false;
      settings = { StartupWMClass = "proton-authenticator"; };
    };
  };
}
