{ config, ... }:

let
  userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {

    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      font = {
        name = "${config.common.style.fontFamily}";
        size = 14;
      }; 
    };
  };
}
