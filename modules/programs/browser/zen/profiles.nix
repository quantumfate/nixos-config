{ config, inputs, pkgs, ... }:

let
  userCfg = config.common.user;
  globalSettings = {
    "zen.tabs.show-newtab-vertical" = false;
    "zen.urlbar.behavior" = "float";
    "zen.view.compact.enable-at-startup" = true;
    "zen.view.compact.hide-toolbar" = true;
    "zen.view.compact.toolbar-flash-popup" = true;
    "zen.view.show-newtab-button-top" = false;
    "zen.view.compact.toolbar-flash-popup.duration" = 1500;
    "zen.view.window.scheme" = 0;
    "zen.welcome-screen.seen" = true;
    "zen.workspaces.continue-where-left-off" = false;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    # Mods
    ## Lean
    "mod.lean.bookmarks" = false;
    "mod.lean.show-translation" = false;
    "mod.lean.bottom-buttons" = false;
    "mod.lean.hide-zoom" = true;
    "mod.lean.ninja-top-buttons" = false;
    "mod.lean.pinned-ext" = true;
    "mod.lean.pinned-ext.workspaces" = true;
    "mod.lean.show-pageactions" = false;
    "mod.lean.top-workspace" = false;

    ## Zen Context Menu
    "uc.fixcontext.ergonomicsfortabs" = true;
    "uc.hidecontext.askchatbot" = false;
    "uc.hidecontext.bookmark" = true;
    "uc.hidecontext.copylink" = true;
    "uc.hidecontext.duplicatetab" = true;
    "uc.hidecontext.frame" = false;
    "uc.hidecontext.mutetab" = true;
    "uc.hidecontext.printselection" = true;
    "uc.hidecontext.reloadtab" = true;
    "uc.hidecontext.screenshot" = true;
    "uc.hidecontext.searchinpriv" = true;
    "uc.hidecontext.selectalltabs" = true;
    "uc.hidecontext.selectalltext" = true;
    "uc.hidecontext.separators" = true;
  };
  extPackages =
    with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
      ublock-origin
      keepassxc-browser
    ];

in {
  home-manager.users."${userCfg.name}" = {
    programs.zen-browser = {
      profiles = {
        "default" = rec {
          id = 0;
          isDefault = true;
          settings = globalSettings;
          containersForce = true;
          containers = {
            Personal = {
              color = "purple";
              icon = "tree";
              id = 1;
            };
            Coding = {
              color = "blue";
              icon = "briefcase";
              id = 2;
            };
            Gaming = {
              color = "yellow";
              icon = "chill";
              id = 3;
            };
          };
          extensions.packages = extPackages;
          spacesForce = true;
          spaces = {
            "Personal" = {
              id = "c6de089c-410d-4206-961d-ab11f988d40a";
              icon = "🌹";
              position = 1000;
              container = containers."Personal".id;
            };
            "Coding" = {
              id = "cdd10fab-4fc5-494b-9041-325e5759195b";
              icon = "🖥";
              container = containers."Coding".id;
              position = 2000;
            };
            "Gaming" = {
              id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
              icon = "🎮";
              container = containers."Gaming".id;
              position = 3000;
            };
          };
          bookmarks = {

          };
        };
        "dofus" = rec {
          id = 1;
          settings = globalSettings;
          containersForce = true;
          containers = {
            Dofus = {
              color = "purple";
              icon = "tree";
              id = 1;
            };
          };
          extensions.packages = extPackages;
          spacesForce = true;
          spaces = {
            "Dofus" = {
              id = "d748ace5-c1c3-45e5-bd31-a332bea82411";
              icon = "🥚";
              position = 1000;
              container = containers."Dofus".id;
            };
          };
        };
      };
    };
  };
}
