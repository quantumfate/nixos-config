{ confing, pkgs, lib, ... }:

let
  test = rec {
    rgb_attr = import ./rgb_attr.nix;
    bare_hex = import ./bare_hex.nix;
    # hex = builtins.mapAttrs ();
  };
in {
  catppuccin = {
    rgb = import ./rgb_attr.nix;
    hsl = import ./hsl.nix;
    hex = import ./hex.nix; # TODO: map '#' to bare
    latte = self.catppuccin

  };

  #imports = [
  #  ./bare.nix
  #  ./hex.nix
  #  ./hsl.nix
  #  ./rgb_attr.nix
  #];
}
