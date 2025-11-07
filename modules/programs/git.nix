{ config, lib, ... }:

let
  cfg = config.userPrograms.git;
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
in {
  options.userPrograms.git.enable =
    lib.mkEnableOption "Git configuration for the user.";

  home-manager.users."${userCfg.userName}" = {
    programs.git = {
      enable = cfg.enable;
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
