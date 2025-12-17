{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # Monospace
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.inconsolata
    nerd-fonts.hack
    nerd-fonts.caskaydia-cove
    nerd-fonts.iosevka
    nerd-fonts.dejavu-sans-mono
    # sans serif
    nerd-fonts.arimo
    nerd-fonts.overpass
    dejavu_fonts
  ];
}
