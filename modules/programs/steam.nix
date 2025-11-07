{ pkgs, config, lib, ... }:

# TODO: eventually add ProtonGE for more compatibility

let
  cfg = config.userPrograms.steam;
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
in
{

  options.userPrograms.steam.enable = lib.mkEnableOption "Steam client.";

  programs.steam.enable = cfg.enable;
  programs.steam.gamescopeSession.enable = cfg.enable;

  environment.systemPackages = lib.mkIf cfg.enable [
    pkgs.mangohud
  ];

  programs.gamemode.enable = cfg.enable;

}