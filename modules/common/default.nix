{ lib, config, pkgs, ... }:

let cfg = config.common;
in {
  options.common = lib.mkOption {
    type = lib.types.attrs;
    default = { };
    description = "Configuration options shared across different hosts.";
  };

  imports = [ ./user.nix ./peripherals.nix ./config.nix ./lib.nix ];
}
