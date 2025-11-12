{ lib, config, pkgs, ... }:

{
  options.common.style = {
    _options = lib.mkOption {
      default = { };
      description = ''
        Configuration options for aesthetics.
      '';
    };

    fontFamily = lib.mkOption {
        type = lib.types.str;
        default = "Monospace";
        description = ''
          Font family.
        '';
      };
    };

    borderRadius = lib.mkOption {
      type = lib.types.int;
      default = 8;
      description = "Border Radius for widgets, windows, etc.";
    };
  };
}
