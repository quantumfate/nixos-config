{ config, pkgs, ... }:

let
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    home.file.".config/hypr/hyprqt6engine.conf" = {
      enable = true;
      text = ''
        theme {
          color_scheme = ${pkgs.catppuccin-qt5ct.outPath}/share/qt6ct/colors/catppuccin-${config.common.style.catppuccin.flavor}-${config.common.style.catppuccin.accent}.conf
          icon_theme = "papirus-icon-theme"
          style = "catppuccin-kvantum"
          font_fixed = ${config.common.style.guiFont}
          font_fixed_size = 12
          font = ${config.common.style.guiFont}
          font_size = 12
        }
        misc {
          single_click_activate = true
          menus_have_icons = true
          shortcuts_for_context_menus = true
        }
      '';
    };
  };
}
