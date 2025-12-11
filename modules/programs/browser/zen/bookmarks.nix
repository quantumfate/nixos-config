{ config, inputs, pkgs, ... }:

let userCfg = config.common.user;

in {
  home-manager.users."${userCfg.name}" = {
    programs.zen-browser = {
      profiles = {
        "default" = {
          bookmarks = {
            force = true;
            settings = [
              {
                name = "Wikipedia";
                tags = [ "wiki" ];
                keyword = "wiki";
                url =
                  "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
              }
              {
                name = "kernel.org";
                tags = [ "linux" "kernel" ];
                url = "https://www.kernel.org";
              }
              "separator"
              {
                toolbar = true;
                name = "Bookmarks Toolbar";
                bookmarks = [
                  {
                    name = "Youtube";
                    tags = [ "media" ];
                    url = "https://www.youtube.com/";
                  }
                  {
                    name = "Crunchyroll";
                    tags = [ "media" ];
                    url = "https://www.crunchyroll.com/discover";
                  }
                  "separator"
                  {
                    name = "Github";
                    tags = [ "social" "programming" ];
                    url = "https://github.com/";
                  }
                  {
                    name = "Hyprland Wiki";
                    tags = [ "programming" "ricing" "linux" ];
                    url = "https://wiki.hypr.land/";
                  }
                  "separator"
                  {
                    name = "Nix Sites";
                    bookmarks = [
                      {
                        name = "homepage";
                        url = "https://nixos.org/";
                      }
                      {
                        name = "wiki";
                        tags = [ "wiki" "nix" ];
                        url = "https://wiki.nixos.org/";
                      }
                      {
                        name = "Nix Language libdoc";
                        tags = [ "nix" "lib" "doc" ];
                        url =
                          "https://nixos.org/manual/nixpkgs/stable/#chap-functions";
                      }
                      {
                        name = "Home-Manager Option Search";
                        tags = [ "nix" "home" "doc" "options" ];
                        url =
                          "https://home-manager-options.extranix.com/?query=&release=release-25.11";
                      }
                      {
                        name = "NixOS Option Search";
                        tags = [ "nix" "doc" "options" ];
                        url = "https://search.nixos.org/options?";
                      }
                      {
                        name = "NixOS Package Search";
                        tags = [ "nix" "doc" "packages" ];
                        url = "https://search.nixos.org/packages?";
                      }
                      {
                        name = "NixOS Flake Search";
                        tags = [ "nix" "doc" "flake" ];
                        url = "https://search.nixos.org/flakes?";
                      }
                    ];
                  }
                ];
              }
            ];
          };
        };
        "dofus" = {
          bookmarks = {
            force = true;
            settings = [{
              toolbar = true;
              name = "Bookmarks Toolbar";
              bookmarks = [
                {
                  name = "Youtube";
                  tags = [ "media" ];
                  url = "https://www.youtube.com/";
                }
                {
                  name = "Dofus";
                  tags = [ "homepage" ];
                  url = "https://www.dofus.com/en/mmorpg/discover";
                }
                {
                  name = "DPLN";
                  tags = [ "quest" "tutorial" ];
                  url = "https://www.dofuspourlesnoobs.com/";
                }
                {
                  name = "Dofensive";
                  tags = [ "monster" "info" "strategy" ];
                  url = "https://dofensive.com/en";
                }
                {
                  name = "Domage";
                  tags = [ "maging" "info" "runes" ];
                  url = "https://dofensive.com/en/domage";
                }
                {
                  name = "Dofusbook";
                  tags = [ "builds" "strategy" "sets" ];
                  url = "https://www.dofusbook.net/en/";
                }
                {
                  name = "Dofusdb";
                  tags = [ "wiki" "doc" ];
                  url = "https://dofusdb.fr/en";
                }
                {
                  name = "Barbofus";
                  tags = [ "fashion" "planner" ];
                  url = "https://barbofus.com/";
                }
              ];
            }];
          };
        };
      };
    };
  };
}
