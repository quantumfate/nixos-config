{ config, lib, ... }:

{
  imports = [
    ./binds.nix
    ./main.nix
    ./workspaces.nix
    ./startup.nix
    ./windowrules.nix
    ./hyprpaper.nix
  ];
}