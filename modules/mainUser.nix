{ lib, config, pkgs, ... }:

let cfg = config.mainUser;
in {
  options = {
    mainUser.enable = lib.mkEnableOption "enable user module";
    mainUser.userName = lib.mkOption {
      default = "nixos";
      description = ''
        username
      '';
    };
    mainUser.shell = lib.mkOption {
      default = pkgs.bash;
      description = ''
        shell
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      description = "main user";
      shell = cfg.shell;
    };
  };
}

