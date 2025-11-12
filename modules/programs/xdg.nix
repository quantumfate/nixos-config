{ config, pkgs, lib, inputs, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common;
in {

  home-manager.users."${userCfg.userName}" = {
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps.defaultApplications = {
        "x-scheme-handler/http" = [ "brave.desktop" ];
        "x-scheme-handler/https" = [ "brave.desktop" ];
        "text/html" = [ "brave.desktop" ];
        "application/pdf" =
          [ "zathura.desktop" "brave.desktop" ];
      };

    };
  };
}
