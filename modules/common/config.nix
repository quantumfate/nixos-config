{ lib, config, pkgs, ... }:

let cfg = config.common;
in {
  config = {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      description = "main user";
      shell = cfg.shell;
    };
  };
}
