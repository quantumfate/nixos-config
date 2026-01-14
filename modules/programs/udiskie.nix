{ config, ... }:

let
  userCfg = config.common.user;
in
{
  services.udisks2.enable = true;

  home-manager.users."${userCfg.name}" = {
    services.udiskie = {
      enable = true;
      automount = true;
    };
  };
}
