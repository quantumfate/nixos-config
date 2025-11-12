{ lib, config, pkgs, ... }:

{
  options.common = {
    userName = lib.mkOption {
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
