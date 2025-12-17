{ config, ... }:

let
  userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {

    programs.foot = {
      enable = true;
      settings = { 
        main = {
          font = "${config.common.style.terminalFont}:size=14";
          pad = "15x15";
        };
      };
    };
  };
}
