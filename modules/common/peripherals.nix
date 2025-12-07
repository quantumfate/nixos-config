{ lib, ... }:

{
  options.common.peripherals = {
    _options = lib.mkOption {
      default = { };
      description = "Configuration options for peripherals.";
    };

    monitors = lib.mkOption {
      type = lib.types.nullOr (lib.types.listOf lib.types.str);
      default = null;
      description = "A List of Monitors such as eDP-1, DP-1 or HDMI-1-A.";
    };

    primaryMonitor = {
      _options = lib.mkOption {
        default = { };
        description = "Configuration options for the Primary monitor.";
      };
      name = lib.mkOption {
        type = lib.types.str;
        default = "eDP-1";
        description = "The primary monitor name.";
      };
      mode = lib.mkOption {
        type = lib.types.str;
        default = "1920x1080";
        description = "The primary monitor resolution.";
      };
      rate = lib.mkOption {
        type = lib.types.str;
        default = "60";
        description = "The primary monitor refresh rate.";
      };
    };

  };
}
