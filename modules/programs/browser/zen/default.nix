{ config, pkgs, inputs, lib, ... }:

let
  userCfg = config.common.user;
  catppuccinZenTheme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "zen-browser";
    rev = "c855685442c6040c4dda9c8d3ddc7b708de1cbaa";
    sha256 = "sha256-5A57Lyctq497SSph7B+ucuEyF1gGVTsuI3zuBItGfg4=";
  };

  catppuccinTargets = [ ".zen/default/chrome" ".zen/dofus/chrome" ];

  capitalize = str:
    lib.strings.toUpper (lib.strings.substring 0 1 str)
    + lib.strings.substring 1 (lib.strings.stringLength str) str;

  flavor = capitalize config.common.style.catppuccin.flavor;
  accent = capitalize config.common.style.catppuccin.accent;
in {
  imports = [ ./profiles.nix "${inputs.my-zen-bookmarks}/bookmarks.nix" ];
  home-manager.users."${userCfg.name}" = {
    imports = [ inputs.zen-browser.homeModules.twilight ];

    home.file = lib.attrsets.genAttrs catppuccinTargets (path: {
      source = "${catppuccinZenTheme}/themes/${flavor}/${accent}/";
      recursive = true;
    });

    programs.zen-browser = {
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
        DisableFirefoxAccounts = false; # needed for sync
        DisableFirefoxScreenshots = true;
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "always";
        OfferToSaveLogins = false;
        OverrideFirstRunPage = "";
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        ExtensionSettings = mkExtensionSettings {
          "{32a6dd4b-a3e6-4571-bc4c-9127d1787096}" = "KeePassXC-Browser";
          "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons";
          "dofus-translate@isthos.com" = "Dofus Translator";
          "{e74f2cbf-fccb-4eee-bca3-7b490bc986cb}" =
            "Unhook - Remove YouTube Recommended & Shorts";
          "{bbb880ce-43c9-47ae-b746-c3e0096c5b76}" =
            "Catppuccin for Web File Explorer Icons";
          "{295bb111-99ed-415c-8f6a-a731ec1d8123}" = "Dark Reader";
          "{f0b41b17-1558-42c8-b535-f162c07f2642}" = "uBlock Origin";
        };
      };
    };
  };
}
