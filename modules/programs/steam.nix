{
  pkgs,
  config,
  lib,
  ...
}:

# TODO: eventually add ProtonGE for more compatibility

let
  cfg = config.common.modules.steam;
in
{
  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;

    environment.systemPackages = with pkgs; [ mangohud ];

    programs.gamemode.enable = true;
  };
}
