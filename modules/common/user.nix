{ lib, config, pkgs, ... }:

{
  options.common.user = {
    name = lib.mkOption {
      default = "quantum";
      description = ''
        The hosts main user.
      '';
    };
    shell = lib.mkOption {
      default = pkgs.bash;
      description = ''
        The shell used by the main user.
      '';
    };
    groups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "wheel" "networkmanager" ];
      description = "Additional user groups.";
    };
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [ ];
      description = "Additional packages to install through home-manager.";
    };
  };
}
