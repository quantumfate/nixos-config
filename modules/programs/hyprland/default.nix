{ config, lib, ... }:

let
  cfg = config.userPrograms.hyprland;
in {
  options.userPrograms.hyprland.enable =
    lib.mkEnableOption "Hyprland configuration.";
  imports = lib.mkIf cfg.enable [
    ./binds.nix
    ./main.nix
    ./workspaces.nix
    ./startup.nix
  ];
}
