{ config, ... }:

let
  userCfg = config.common.user;
  catppuccin = config.theme.catppuccin;
in
{
  home-manager.users."${userCfg.name}" = {
    home.file.".config/hypr/hyprtoolkit.conf" = {
      text = ''
        background = ${catppuccin.rgba.crust 1} 
        base = ${catppuccin.rgba.base 1}        
        text = ${catppuccin.rgba.text 1}        
        alternate_base = ${catppuccin.rgba.mantle 1}        
        bright_text = ${catppuccin.rgba.text 1}        
        accent = ${catppuccin.rgba."${config.common.style.catppuccin.accent}" 1}        
        accent_secondary = ${catppuccin.rgba.teal 1}        
        h1_size = 20
        h2_size = 16
        h3_size = 14
        font_size = 12
        small_font_size = 11
        icon_theme = Papirus-Dark
        font_family = ${config.common.style.guiFont}
        font_family_monospace = ${config.common.style.terminalFont}
      '';
    };
  };
}
