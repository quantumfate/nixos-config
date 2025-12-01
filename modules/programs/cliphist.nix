{ config, ... }:

let
  userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {
    services.cliphist = {
      enable = true;
      allowImages = true;
      systemdTargets = [
        "graphical-session.target"
        "graphical.target"
      ];
    };
  };
}
