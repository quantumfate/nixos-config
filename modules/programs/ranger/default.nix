{ config, pkgs, ... }:

let
  userCfg = config.common.user;
  scriptDir = "/home/${userCfg.name}/.config/hypr/scripts";
in {
  home-manager.users."${userCfg.name}" = {
    home.packages = with pkgs; [ fzf ];
    home.file.".config/ranger/commands.py" = {
      source = ./commands.py;
      executable = true;
    };

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
    programs.ranger = {
      enable = true;
      settings = {
        column_ratios = "1,3,3";
        confirm_on_delete = "never";
        scroll_offset = 8;
        unicode_ellipsis = true;
        map = [ "<A-f> fzf_select" "<C-g> fzf_locate" ];
      };
    };
  };
}

