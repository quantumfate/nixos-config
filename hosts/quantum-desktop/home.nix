{ config, pkgs, ... }:

{
  imports = [ ../../modules/home-manager ../../modules/packages.nix ];
  home.username = "quantum";
  home.homeDirectory = "/home/quantum";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  programs.bash = {
    enable = true;
    shellAliases = { btw = "echo i use hyprland btw"; };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec hyprland
      fi
    '';
  };

  home.file = {

  };

  home.sessionVariables = { EDITOR = "nvim"; };

  services.udiskie = {
    enable = true;
    automount = true;
  };

  programs.home-manager.enable = true;
}
