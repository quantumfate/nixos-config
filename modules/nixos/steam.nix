{ pkgs, ... }:

# TODO: eventually add ProtonGE for more compatibility

{

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
  ];

  programs.gamemode.enable = true;

}