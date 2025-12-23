{ config, pkgs, ... }:

let userCfg = config.common.user;
in {
  imports = [ ./catppuccin ./stylix.nix ];

  home-manager.users."${userCfg.name}" = {
    #home.pointerCursor = {
    #  gtk.enable = true;
    #  # x11.enable = true;
    #  package = pkgs.catppuccin-cursors.mochaMauve;
    #  name = "Bibata Modern Amber";
    #  size = 24;
    #};

    #home.file.".icons/hicolor/" = {
    #  source = "${pkgs.papirus-icon-theme}/share/icons/";
    #  recursive = true;
    #};
    gtk = {
      enable = true;
      colorScheme = "dark";
      gtk2.enable = true;
      gtk3.enable = true;
      font = {
        name = "${config.common.style.guiFont}";
        size = 14;
      };

      theme = {
        name = "Juno-palenight";
        package = pkgs.juno-theme;
      };
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    };
    qt = {
      enable = true;
      style = { name = "kvantum"; };

    };
  };
}
