{ config, pkgs, ... }:

let userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    programs.hyprpanel = {
      enable = true;
      settings = { };
    };
  };
}
