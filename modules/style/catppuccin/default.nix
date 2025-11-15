{ config, pkgs, lib, ... }:

let
  flavor = config.common.catppuccin.flavor;
  catppuccin = {
    rgb = (import ./rgb_attr.nix).${flavor};
    hsl = (import ./hsl.nix).${flavor};
    hex = (import ./bare_hex.nix).${flavor};
  };
in {
  options.theme.catppuccin = lib.mkOption {
    default = {};
    description = " ";
  };
  
  config.theme.catppuccin = catppuccin;
}
