{ config, pkgs, ... }:

{
  imports =
    [ ../home-manager ../home-manager/packages.nix ];
  home.username = "quantum";
  home.homeDirectory = "/home/quantum";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  programs.home-manager.enable = true;
}
