{ config, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.mainUser;

  flavor = "mocha";
  accent = "rosewater";

  catppuccinCfg = {
    enable = true;
    flavor = "mocha";
    accent = "rosewater";
  };

in {
  catppuccin = catppuccinCfg;

  home-manager.users."${userCfg.userName}" = { catppuccin = catppuccinCfg; };
}
