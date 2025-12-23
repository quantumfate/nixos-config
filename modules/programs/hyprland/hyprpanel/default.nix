{ config, pkgs, ... }:

let userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    programs.hyprpanel = { enable = true; };
  };
  home.file.".config/hyprpanel/config.json" = {
    source = ./config.json;
  };
}
