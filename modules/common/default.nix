{ lib, ... }:

{
  options.common = {
    _options = lib.mkOption {
      default = { };
      description = "Common Configuration options for all hosts.";
    };
    hostName = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      description = "Hostname of the system.";
    };
    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Europe/Berlin";
      description = "Timezone of the host.";
    };

    defaultLocale = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
      description = "Default locale of the host.";
    };
  };

  imports =
    [ ./user.nix ./peripherals.nix ./style.nix ./lib.nix ./keyboard.nix ./modules.nix ];
}
