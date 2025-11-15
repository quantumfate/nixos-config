{ pkgs, config, lib, ... }:

# TODO: eventually add ProtonGE for more compatibility

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in
{
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
  ];

  programs.gamemode.enable = true;

}