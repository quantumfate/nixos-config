{ config, ... }:

let
  userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps.defaultApplications = {
        "x-scheme-handler/http" = [ "zen-twilight.desktop" ];
        "x-scheme-handler/https" = [ "zen-twilight.desktop" ];
        "text/html" = [ "neovim.desktop" "zen-twilight.desktop" ];
        "application/pdf" =
          [ "zathura.desktop" "zen-twilight.desktop" ];
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
