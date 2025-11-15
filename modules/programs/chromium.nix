{ config, pkgs, lib, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
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
      commandLineArgs = [ "--force-dark-mode" ];
    };
  };
}
