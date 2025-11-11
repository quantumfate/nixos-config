{ config, pkgs, lib, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.mainUser;

  qt5ctRepo = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "qt5ct";
    rev = "main"; # Stable commit hash
    hash = "sha256-wDj6kQ2LQyMuEvTQP6NifYFdsDLT+fMCe3Fxr8S783w=";
  };

  flavorMap = {
    latte = "latte";
    frappe = "frappe";
    macchiato = "macchiato";
    mocha = "mocha";
  };

  installCatppuccinQt5CT = flavor:
    let selectedFlavorName = flavorMap.${flavor};
    in {
      home-manager.users."${userCfg.userName}" = {
        home.file.".config/qt5ct/" = {
          source = ./configs/qt5ct.conf;
        };
        # Installs the chosen theme file into ~/.config/qt5ct/colors/
        home.file.".config/qt5ct/colors/catppuccin-${selectedFlavorName}-teal.conf" =
          {
            source =
              "${qt5ctRepo}/themes/catppuccin-${selectedFlavorName}-teal.conf";
            executable = false;
          };
        home.file.".config/qt6ct/colors/catppuccin-${selectedFlavorName}-teal.conf" =
          {
            source =
              "${qt5ctRepo}/themes/catppuccin-${selectedFlavorName}-teal.conf";
            executable = false;
          };
        qt = {
          enable = true;
          style = {
            package = pkgs.catppuccin-kvantum;
            name = "kvantum";
          };
        };
        gtk = {
          enable = true;
          theme = {
            name = "Catppuccin-Mocha-Standard-Teal-Dark";
            package = pkgs.catppuccin-gtk.override {
              accents = [ "teal" ];
              size = "standard";
              variant = "mocha";
            };
          };
          
          cursorTheme = {
            name = "Catppuccin-Mocha-Dark-Cursors";
            package = pkgs.catppuccin-cursors.mochaDark;
          };
          gtk3 = { extraConfig.gtk-application-prefer-dark-theme = true; };
        };

        home.pointerCursor = {
          gtk.enable = true;
          name = "Catppuccin-Mocha-Dark-Cursors";
          package = pkgs.catppuccin-cursors.mochaDark;
          size = 16;
        };

        xdg.configFile."Kvantum/kvantum.kvconfig".source =
          (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
            General.theme = "Catppuccin-Mocha-Teal";
          };
      };
    };

in { } // installCatppuccinQt5CT "mocha"
