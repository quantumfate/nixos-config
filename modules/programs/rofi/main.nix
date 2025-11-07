{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
in {
  home-manager.users."${userCfg.userName}" = {
    # https://mynixos.com/options/programs.rofi
    programs.rofi = { enable = true; };
  };
}
