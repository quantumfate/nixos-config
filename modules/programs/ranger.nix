{ config, ... }:

let
  userCfg = config.common.user;
  scriptDir = "/home/${userCfg.name}/.config/hypr/scripts";
in {
  home-manager.users."${userCfg.name}" = {
    xdg.desktopEntries."ranger" = {
      type = "Application";
      name = "ranger";
      genericName = "File Manager";
      exec = "${scriptDir}/open-tui.sh ranger %F";
      comment = "Launches the ranger file manager.";
      icon = "utilities-terminal";
      terminal = false;
      mimeType = [ "inode/directory" ];
      startupNotify = true;
      categories = [ "System" "FileTools" "FileManager" ];
      settings = {
        "X-MultipleArgs" = "false";
      #version = "1.0";
      };
    };
    programs.ranger = { enable = true; };
  };
}

