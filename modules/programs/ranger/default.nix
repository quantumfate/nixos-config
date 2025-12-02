{ config, pkgs, ... }:

let
  userCfg = config.common.user;
  scriptDir = "/home/${userCfg.name}/.config/hypr/scripts";
in {
  services.locate = {
    enable = true;
    package = pkgs.mlocate;
  };
  home-manager.users."${userCfg.name}" = {
    home.packages = with pkgs; [ fzf mlocate libsixel ];
    home.file.".config/ranger/commands.py" = {
      source = ./commands.py;
      executable = true;
    };
    home.file.".config/ranger/rangercd.sh" = {
      source = ./rangercd.sh;
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
        preview_images = true;
        preview_images_method = "sixel";
      };
      mappings = {
        "<A-f>" = "fzf_select";
        "<C-g>" = "fzf_locate";
        "<C-n>" = "fzf_content_open";
        "<C-y>" = "YankContentWl";
      };
    };
  };
}

