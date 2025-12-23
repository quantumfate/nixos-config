{ config, pkgs, ... }:

let userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    home.packages = with pkgs; [ hyprpanel libnotify ];
    home.file.".config/hyprpanel/config.json" = { source = ./config.json; };
  };

}
