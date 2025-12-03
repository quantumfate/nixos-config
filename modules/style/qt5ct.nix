{ config, pkgs, ... }:

let
  userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {

    gtk = {
      enable = true;

      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    };
    qt = {
      enable = true;
      style = {
        name = "kvantum";
        package = pkgs.catppuccin-kvantum;
      };
    };
  };
}
