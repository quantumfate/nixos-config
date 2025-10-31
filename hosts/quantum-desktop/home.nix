{ config, pkgs, ... }:

{
  imports =
    [ ../../modules/home-manager ../../modules/home-manager/packages.nix ];
  home.username = "quantum";
  home.homeDirectory = "/home/quantum";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  services.udiskie = {
    enable = true;
    automount = true;
  };

  programs.home-manager.enable = true;
}
