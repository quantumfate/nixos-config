{ lib, config, pkgs, ... }:

let cfg = config.main-user;
in {
  options = {
    main-user.enable = lib.mkEnableOption "enable user module";
    main-user.userName = lib.mkOption {
      default = "mainuser";
      description = ''
        username
      '';
    };
    main-user.shell = lib.mkOption {
      default = pkgs.zsh;
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

