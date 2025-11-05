{ config, lib, ... }:

let cfg = config.userPrograms.waybar;
in {
  options.userPrograms.enable = lib.mkEnableOption "Waybar configuration";
  imports = lib.mkIf cfg.enable [ ./main.nix ./modules.nix ./style.nix ];
}
