{ config, ... }:

let
  userCfg = config.common.user;
  scriptDir = "/home/${userCfg.name}/.config/hypr/scripts";
in {
  home-manager.users."${userCfg.name}" = {
    xdg.desktopEntries."ranger" = {
      version = "1.0";
      type = "Application";
      name = "ranger";
      exec = "${scriptDir}/open-tui.sh ranger %F";
      comment =
        "Launches the ranger file manager.";
      icon = "utilities-terminal";
      terminal = false;
      "X-MultipleArgs" = false;
      mimetype = "inode/directory";
      startupnotify = true;
      categories= "System;FileTools;FileManager";
    };
    programs.ranger = {
      enable = true;
    };
  };
}

