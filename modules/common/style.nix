{ lib, ... }:

{
  options.common.style = {
    _options = lib.mkOption {
      default = { };
      description = ''
        Configuration options for aesthetics.
      '';
    };

    guiFont = lib.mkOption {
      type = lib.types.str;
      default = "Monospace";
      description = ''
        Font family.
      '';
    };
    terminalFont = lib.mkOption {
      type = lib.types.str;
      default = "Monospace";
      description = ''
        Font family.
      '';
    };
    borderRadius = lib.mkOption {
      type = lib.types.int;
      default = 10;
      description = "Border Radius for widgets, windows, etc.";
    };
    catppuccin = {
      _options = lib.mkOption {
        default = { };
        description = "Configuration options for the catppuccin theme.";
      };

      flavor = lib.mkOption {
        type = lib.types.str;
        default = "mocha";
        description = "Catppuccin's flavor.";
      };

      accent = lib.mkOption {
        type = lib.types.str;
        default = "mauve";
        description = "Catppuccin's accent color.";
      };
    };
  };
}
