{ config, ... }:

let userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Leon Connor Holm";
          email = "62796852+quantumfate@users.noreply.github.com";
        };
        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };
  };
}
