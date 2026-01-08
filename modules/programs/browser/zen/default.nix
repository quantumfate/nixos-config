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
  globalSettings = {
    "app.normandy.first_run" = false;

    "browser.aboutConfig.showWarning" = false;
    "browser.bookmarks.addedImportButton" = true;
    "browser.download.panel.shown" = true;

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

    "mod.sameerasw.zen_bg_blur" = "3px";
    "mod.sameerasw.zen_bg_color_enabled" = false;
    "mod.sameerasw.zen_bg_img" =
      "url('https://github.com/sameerasw/my-internet/blob/main/wallpapers/zen-coral-01.jpeg?raw=true')";
    "mod.sameerasw.zen_bg_img_enabled" = true;
    "mod.sameerasw.zen_bg_img_not_fullscreen" = true;
    "mod.sameerasw.zen_bg_opacity" = 0.8;
    "mod.sameerasw.zen_compact_sidebar_width" = "165px";
    "mod.sameerasw.zen_no_shadow" = true;
    "mod.sameerasw.zen_notab_img" =
      "url('https://github.com/sameerasw/my-internet/blob/main/wave-light.png?raw=true')";
    "mod.sameerasw.zen_notab_img_opacity" = 1;
    "mod.sameerasw.zen_notab_img_size" = "150px";
    "mod.sameerasw.zen_tab_switch_anim" = true;
    "mod.sameerasw.zen_trackpad_anim" = false;
    "mod.sameerasw.zen_transparency_color" = "#00000000";
    "mod.sameerasw.zen_transparent_glance_enabled" = false;
    "mod.sameerasw.zen_transparent_sidebar_enabled" = true;
    "mod.sameerasw.zen_urlbar_zoom_anim" = false;
    "mod.sameerasw_zen_animations" = 1;
    "mod.sameerasw_zen_compact_sidebar_type" = 0;
    "mod.sameerasw_zen_empty_tab_logo" = 1;
    "mod.sameerasw_zen_light_tint" = 2;

    ## Better Findbar
    "theme-better_find_bar-enable_custom_background" = true;
    "theme.better_find_bar.hide_find_status" = false;
    "theme.better_find_bar.hide_found_matches" = false;
    "theme.better_find_bar.hide_highlight" = "not_hide";
    "theme.better_find_bar.hide_match_case" = "not_hide";
    "theme.better_find_bar.hide_match_diacritics" = "not_hide";
    "theme.better_find_bar.hide_whole_words" = "not_hide";
    "theme.better_find_bar.horizontal_position" = "default";
    "theme.better_find_bar.instant_animations" = true;
    "theme.better_find_bar.textbox_width" = 800;
    "theme.better_find_bar.transparent_background" = true;
    "theme.better_find_bar.vertical_position" = "top";

    ## Better Tab Indicators
    "theme.better_uniextbtn.custom" =
      "url(chrome://branding/content/icon32.png)";
    "theme.better_uniextbtn.default" = "Custom";
    ## Zen Context Menu
    "uc.fixcontext.applyzenaccent" = true;
    "uc.fixcontext.applyzengradient" = true;
    "uc.fixcontext.restoreicons" = true;
    "uc.tabs.custom_color_hex" = "#000000";
    "uc.tabs.dim_unloaded" = false;
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
      proton-pass
      proton-vpn
      youtube-cards
      darkreader
      catppuccin-mocha-mauve
      catppuccin-web-file-icons
      github-file-icons
    ];
  validateUniqueIds = profile:
    let
      pinIds = builtins.attrValues
        (builtins.mapAttrs (name: pin: pin.id) profile.pins);
      spaceIds = builtins.attrValues
        (builtins.mapAttrs (name: space: space.id) profile.spaces);
      containerIds = builtins.attrValues
        (builtins.mapAttrs (name: container: container.id) profile.containers);
      allIds = pinIds ++ spaceIds ++ containerIds;

      grouped = lib.lists.groupBy (id: builtins.toString id) allIds;
      duplicates =
        lib.filterAttrs (id: instances: builtins.length instances > 1) grouped;
    in if duplicates == { } then
      profile
    else
      throw
      "Duplicate IDs found: ${builtins.toJSON (builtins.attrNames duplicates)}";
in {
  home-manager.users."${userCfg.name}" = {
    imports = [ inputs.zen-browser.homeModules.twilight ];
    home.file = lib.attrsets.genAttrs catppuccinTargets (path: {
      source = "${catppuccinZenTheme}/themes/${flavor}/${accent}/";
      recursive = true;
    }) // lib.attrsets.genAttrs zen_profiles
      (profile: { source = ./kb-shortcuts.json; });

    programs.zen-browser = {
      enable = true;
      nativeMessagingHosts = [ pkgs.firefoxpwa ];
      policies = {
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
