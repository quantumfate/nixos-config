{ config, ... }:

let
  userCfg = config.common.user;
  catppuccin = config.theme.catppuccin;
in {
  home-manager.users."${userCfg.name}" = {
    home.file.".config/hypr/hyprtoolkit.conf" = {
      text = ''
        background = 0x${catppuccin.rgba_bare_hex.base 1} 
        base = 0x${catppuccin.rgba_bare_hex.base 1}        
        text = 0x${catppuccin.rgba_bare_hex.text 0.9}        
        alternate_base = 0x${catppuccin.rgba_bare_hex.surface0 0.9}        
        bright_text = 0x${catppuccin.rgba_bare_hex.yellow 0.9}        
        accent = 0x${catppuccin.rgba_bare_hex.yellow 0.9}        
        accent_secondary = 0x${catppuccin.rgba_bare_hex.red 0.9}        
        h1_size = 20
        h2_size = 16
        h3_size = 14
        font_size = 12
        small_font_size = 11
        font_family = ${config.common.style.guiFont}
        font_family_monospace = ${config.common.style.terminalFont}
      '';
      
    };
  };
}
