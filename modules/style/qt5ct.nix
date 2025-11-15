{ config, pkgs, lib, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;

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
      home-manager.users."${userCfg.name}" = {

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

      };
    };

in {

  home-manager.users."${userCfg.name}" = {
    home.file.".config/qt5ct/qt5ct.conf" = {
      text = ''
        [Appearance]
        color_scheme_path=/home/quantum/.config/qt5ct/colors/catppuccin-mocha-teal.conf
        custom_palette=true
        icon_theme=Papirus-Dark
        standard_dialogs=gtk3
        style=kvantum-dark

        [Fonts]
        fixed="Sans Serif,9,-1,5,50,0,0,0,0,0"
        general="Sans Serif,9,-1,5,50,0,0,0,0,0"

        [Interface]
        activate_item_on_single_click=1
        buttonbox_layout=0
        cursor_flash_time=1000
        dialog_buttons_have_icons=1
        double_click_interval=400
        gui_effects=@Invalid()
        keyboard_scheme=2
        menus_have_icons=true
        show_shortcuts_in_context_menus=true
        stylesheets=@Invalid()
        toolbutton_style=4
        underline_shortcut=1
        wheel_scroll_lines=3

        [SettingsWindow]
        geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x4l\0\0\x2\xa8\0\0\0\0\0\0\0\0\0\0\x4\x7f\0\0\x2\xcf\0\0\0\x1\x2\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\x4l\0\0\x2\xa8)

        [Troubleshooting]
        force_raster_widgets=1
        ignored_applications=@Invalid()
      '';
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
} // installCatppuccinQt5CT "mocha"
