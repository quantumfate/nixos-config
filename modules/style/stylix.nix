{ pkgs, config, ... }:
let
  userCfg = config.common.user;
  flavor = config.common.style.catppuccin.flavor;

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-${flavor}.yaml";
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "Fira Code Nerd Font";
      };
    };
    autoEnable = true;
  };
in
{

  home-manager.users."${userCfg.name}" = {
    stylix = stylix;
  };
  stylix = stylix;
}
