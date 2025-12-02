{ config, ... }:

let
  userCfg = config.common.user;
in {

  config = {
    home-manager.users."${userCfg.name}" = {
      programs.nushell = {
        enable = true;
      };
    };
  };
}
