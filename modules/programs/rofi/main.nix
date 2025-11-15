{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    # https://mynixos.com/options/programs.rofi
    programs.rofi = { enable = true; };
  };
}
