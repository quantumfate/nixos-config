{ lib, config, pkgs, ... }:

{
  options.common.peripherals = lib.mkOption {
    type = lib.types.attrs;
    default = {};
    description = "Configuration options for peripherals.";

    options = {
      keyboard = lib.mkOption {
        type = lib.types.str;
        default = "standard";
        description = "The external keyboard used on the host.";
      };

      monitors = lib.mkOption {
        type = lib.types.nullOr (lib.types.listOf lib.types.str);
        default = null;
        description = "A List of Monitors such as eDP-1, DP-1 or HDMI-1-A.";
      };
    };
  };
}