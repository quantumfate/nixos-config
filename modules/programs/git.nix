{ config, ... }:

let
  userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Leon Connor Holm";
          email = "leonconnorholm@gmail.com";
          init.defaultBranch = "main";
        };
        global = {
          init.defaultBranch = "main";
        };
      };
    };
  };
}
