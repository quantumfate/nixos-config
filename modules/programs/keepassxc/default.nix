{ config, pkgs, lib, inputs, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {
    programs.keepassxc.enable = true;
    #home.file.".config/keepassxc/keepassxc.ini" = {
    #  source = config.lib.file.mkOutOfStoreSymlink ./config.ini;
    #};
    #home.file.".cache/keepassxc/keepassxc.ini" = {
    #  source = config.lib.file.mkOutOfStoreSymlink ./cache.ini;
    #};
  };
}
