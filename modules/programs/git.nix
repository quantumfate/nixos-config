{ config, lib, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
in {

  home-manager.users."${userCfg.userName}" = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Leon Connor Holm";
          email = "leonconnorholm@gmail.com";
          init.defaultBranch = "main";
        };
      };
    };
  };
}
