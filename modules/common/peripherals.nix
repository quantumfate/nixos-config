{ lib, ... }:

{
  options.common.peripherals = {
    _options = lib.mkOption {
      default = {};
      description = "Configuration options for peripherals.";
    };
    
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
    
    primaryMonitor = lib.mkOption {
      type = lib.types.str;
      default = "DP-1";
      description = "The primary monitor.";
    };  
  };
}