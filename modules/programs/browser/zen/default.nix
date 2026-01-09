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

  zen_profiles = [
    ".zen/dofus/zen-keyboard-shortcuts.json"
    ".zen/default/zen-keyboard-shortcuts.json"
  ];


in {
  home-manager.users."${userCfg.name}" = {
    imports = [ inputs.zen-browser.homeModules.beta ];
    home.file = lib.attrsets.genAttrs catppuccinTargets (path: {
      source = "${catppuccinZenTheme}/themes/${flavor}/${accent}/";
      recursive = true;
    }) // lib.attrsets.genAttrs zen_profiles
      (profile: { source = ./kb-shortcuts.json; });

    programs.zen-browser = {
      enable = true;
      nativeMessagingHosts = [ pkgs.firefoxpwa ];
      policies = {
        #AutofillAddressEnabled = true;
        #AutofillCreditCardEnabled = false;
        #DisableAppUpdate = true;
        #DisableFeedbackCommands = true;
        #DisableFirefoxStudies = true;
        #DisablePocket = true;
        #DisableTelemetry = true;
        #DisableProfileImport = true;
        #DisableSetDesktopBackground = true;
        #DisableFirefoxAccounts = false; # needed for sync
        #DisableFirefoxScreenshots = true;
        #DontCheckDefaultBrowser = true;
        #DisplayBookmarksToolbar = "always";
        #OfferToSaveLogins = false;
        #OverrideFirstRunPage = "";
        #EnableTrackingProtection = {
        #  Value = true;
        #  Locked = true;
        #  Cryptomining = true;
        #  Fingerprinting = true;
        #};
        ExtensionSettings = {
          "dofus-translate@isthos.com" = {
            private_browsing = true;
            default_area = "navbar";
            installation_mode = "force_installed";
            install_url =
              "https://addons.mozilla.org/firefox/downloads/latest/dofus-translate/latest.xpi";
          };
        };
      };
      profiles = inputs.my-zen-config.outputs.profiles;
    };
  };
}
