{ config, pkgs, lib, ... }:

let
  cfg = config.userPrograms.chromium;
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
in {
  options.userPrograms.chromium.enable =
    lib.mkEnableOption "Chrome based browser.";

  home-manager.users."${userCfg.userName}" = {
    programs.chromium = {
      enable = cfg.enable;
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
