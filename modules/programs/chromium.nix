{ config, pkgs, lib, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
in {

  home-manager.users."${userCfg.userName}" = {
    programs.chromium = {
      enable = true;
      extensions = [
        # Dark Reader
        {
          id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
        }

        # Unhook - Remove YouTube Recommended & Shorts
        {
          id = "khncfooichmfjbepaaaebmommgaepoid";
        }

        # FireShot
        { id = "mcbpblocgmgfnpjjppndjkmgjaogfceg"; }
      ];
    };
  };
}
