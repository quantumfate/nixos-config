{ lib, config, pkgs, ... }:

{
  options.common.catppuccin = {
    _options = lib.mkOption {
      default = {};
      description = "Configuration options for the catppuccin theme.";
    };
    
    flavor = lib.mkOption {
      type = lib.types.str;
      default = "mocha";
      description = "Catppuccin's flavor.";
    };

    accent = lib.mkOption {
      type = lib.types.str;
      default = "teal";
      description = "Catppuccin's accent color.";
    };
  };
}