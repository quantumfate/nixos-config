{ config, pkgs, ... }:

let
  userCfg = config.common.user;
in
{
  imports = [
    ./foot.nix
    ./kitty.nix
    ./ranger
    ./shell
    ./btop.nix
    ./fastfetch.nix
  ];
}
