{ config, pkgs, lib, inputs, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps.defaultApplications = {
        "x-scheme-handler/http" = [ "chromium-browser.desktop" ];
        "x-scheme-handler/https" = [ "chromium-browser.desktop" ];
        "text/html" = [ "chromium-browser.desktop" ];
        "application/pdf" =
          [ "zathura.desktop" "chromium-browser.desktop" ];
      };
    };
  };
}
