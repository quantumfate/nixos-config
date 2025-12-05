{ config, ... }:

let
  userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {

    programs.btop = {
      enable = true;
    };
  };
}
