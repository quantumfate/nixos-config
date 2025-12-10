{ config, pkgs, inputs, lib, ... }:

let
  userCfg = config.common.user;
  catppuccinZenTheme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "zen-browser";
    rev = "c855685442c6040c4dda9c8d3ddc7b708de1cbaa";
    sha256 = "sha256-5A57Lyctq497SSph7B+ucuEyF1gGVTsuI3zuBItGfg4=";
  };

  capitalize = str:
    lib.strings.toUpper (lib.strings.substring 0 1 str)
    + lib.strings.substring 1 (lib.strings.stringLength str) str;

  flavor = capitalize config.common.style.catppuccin.flavor;
  accent = capitalize config.common.style.catppuccin.accent;
in {
  home-manager.users."${userCfg.name}" = {
    imports = [ inputs.zen-browser.homeModules.twilight ];
    home.file.".zen/default/chrome" = {
      source = "${catppuccinZenTheme}/themes/${flavor}/${accent}/";
      recursive = true;
    };
    programs.zen-browser = rec {
      enable = true;
      nativeMessagingHosts = [ pkgs.firefoxpwa ];
      policies = let
        mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
          installation_mode = "force_installed";
        });
      in {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableProfileImport = true;
        DisableSetDesktopBackground = true;
        DisableFirefoxAccounts = false;
        DisableFirefoxScreenshots = true;
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "always";
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OverrideFirstRunPage = "";
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        ExtensionSettings = mkExtensionSettings {
          "wappalyzer@crunchlabz.com" = "wappalyzer";
          "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons";
          "dofus-translate@isthos.com" = "Dofus Translator";
          "{e74f2cbf-fccb-4eee-bca3-7b490bc986cb}" =
            "Unhook - Remove YouTube Recommended & Shorts";
          "{bbb880ce-43c9-47ae-b746-c3e0096c5b76}" =
            "Catppuccin for Web File Explorer Icons";
          "addon@darkreader.org" = "Dark Reader";
        };

      };
      profiles."default" = {
        settings = {
          "zen.tabs.show-newtab-vertical" = false;
          "zen.urlbar.behavior" = "float";
          "zen.view.compact.enable-at-startup" = true;
          "zen.view.compact.hide-toolbar" = true;
          "zen.view.compact.toolbar-flash-popup" = true;
          "zen.view.show-newtab-button-top" = false;
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
        extensions.packages =
          with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            ublock-origin
            keepassxc-browser
          ];
        spacesForce = true;
        spaces = let containers = profiles."default".containers;
        in {
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
      };
    };

  };
}
