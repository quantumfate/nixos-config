{ lib, ... }:

{
  options.common.keyboard = {
    _options = lib.mkOption {
      default = {};
      description = "Configuration options for for localization and interaction.";
    };
    
    layout = lib.mkOption {
      type = lib.types.str;
      default = "us";
      description = "The internal keyboard layout used.";
    };

    variant = lib.mkOption {
      type = lib.types.str;
      default = "intl";
      description = "The keyboard variant";
    };
  };
}