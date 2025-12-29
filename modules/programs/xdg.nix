{ config, inputs, pkgs, ... }:

let userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {
    home.file."Projects/.keep".text = "";
    home.file."Projects/gitlab/.keep".text = "";
    home.file."Projects/gitlab/my-nixos-config/.keep".text = "";
    home.file."Projects/github/.keep".text = "";
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = let
          zenDesktopFileName =
            inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight.meta.desktopFileName;
          associations = builtins.listToAttrs (map (name: {
            inherit name;
            value = [ zenDesktopFileName ];
          }) [
            "application/x-extension-shtml"
            "application/x-extension-xhtml"
            "application/x-extension-html"
            "application/x-extension-xht"
            "application/x-extension-htm"
            "x-scheme-handler/https"
            "x-scheme-handler/http"
            "application/xhtml+xml"
            "text/html"

            # Optional, often better left to text/editor:
            # "application/json" 
            # "text/plain"
          ]);

        in associations // { # Use '//' to merge attrsets in Nix

          "application/pdf" = [ "zathura.desktop" zenDesktopFileName ];
          "inode/directory" = [ "ranger.desktop" ];
          "text/x-lua" = [ "nvim.desktop" ];
        };

      };
      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };
  };
}
