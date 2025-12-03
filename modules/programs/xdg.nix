{ config, ... }:

let
  userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps.defaultApplications = {
        "x-scheme-handler/http" = [ "brave-browser.desktop" ];
        "x-scheme-handler/https" = [ "brave-browser.desktop" ];
        "text/html" = [ "neovim.desktop" "brave-browser.desktop" ];
        "application/pdf" =
          [ "zathura.desktop" "brave-browser.desktop" ];
        "inode/directory" = [ "ranger.desktop" ];
        "text/x-lua" = [ "nvim.desktop" ];
      };
      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };
  };
}
