{ lib, config, pkgs, ... }:

let userCfg = config.common.user;
in {
  config = {
    users.users.${userCfg.name} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "ydotool"];
      description = "main user";
      shell = userCfg.shell;
    };
  };
}
