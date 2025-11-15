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
  };
}
