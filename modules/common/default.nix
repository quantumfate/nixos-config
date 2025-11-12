{ lib, config, pkgs, ... }:

let cfg = config.common;
in {
  options.common = {
    _options = lib.mkOption {
      default = { };
      description = "Common Configuration options for all hosts.";
    };
  };

  imports = [ ./user.nix ./peripherals.nix ./style.nix ./config.nix ./lib.nix ];
}
