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
          "*" = {
            blocked_install_message =
              "The addon you are trying to install is not added in the Nix config";
            installation_mode = "blocked";
          };
          "dofus-translate@isthos.com" = {
            private_browsing = true;
            default_area = "navbar";
            installation_mode = "force_installed";
            install_url =
              "https://addons.mozilla.org/firefox/downloads/latest/dofus-translate/latest.xpi";
          };
        };
      };
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
            Finance = {
              color = "purple";
              icon = "dollar";
              id = 3;
            };
            Gaming = {
              color = "yellow";
              icon = "chill";
              id = 4;
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
            "Finance" = {
              id = "fc443ed8-1fa2-462d-998b-49774d46eb4f";
              icon = "💳";
              container = containers."Finance".id;
              position = 3000;
            };
            "Gaming" = {
              id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
              icon = "🎮";
              container = containers."Gaming".id;
              position = 4000;
            };
          };
          pins = {
            "Crunchyroll" = {
              id = "ebc72150-658b-4973-af58-2bb6bea7d7bf";
              container = containers."Personal".id;
              url = "https://www.crunchyroll.com/discover";
              isEssential = true;
              position = 100;
            };
            "YouTube" = {
              id = "68278557-3d07-4080-abf3-094de95b9316";
              container = containers."Personal".id;
              url = "https://www.youtube.com/";
              isEssential = true;
              position = 101;
            };
            "Twitch" = {
              id = "b5d3e223-e320-4743-b71e-04d48ad002cc";
              container = containers."Personal".id;
              url = "https://www.twitch.tv/";
              isEssential = true;
              position = 102;
            };
            "Monkeytype" = {
              id = "7fd1df80-3877-4b1a-a39e-350b4c7d0a7a";
              container = containers."Personal".id;
              url = "https://monkeytype.com/";
              position = 103;
            };
            "Socials" = {
              id = "de58b66a-636a-4879-b8a6-2d18b81a0a3c";
              workspace = spaces."Personal".id;
              isGroup = true;
              isFolderCollapsed = false;
              editedTitle = true;
              position = 104;
            };
            "Reddit" = {
              id = "62cc7289-42b5-45ed-bf19-17f83ae2069e";
              container = containers."Personal".id;
              folderParentId = pins."Socials".id;
              url = "https://www.reddit.com/";
              position = 105;
            };
            "Twitter" = {
              id = "6e61d2ae-c1e8-4ccd-b01d-f5a855729f73";
              container = containers."Personal".id;
              folderParentId = pins."Socials".id;
              url = "https://x.com/";
              position = 106;
            };
            "Github" = {
              id = "a9f85c30-a430-41ef-a723-c4ec27cf96d8";
              container = containers."Coding".id;
              url = "https://github.com/quantumfate";
              isEssential = true;
              position = 200;
            };
            "Gitlab" = {
              id = "a19b38e1-9ac4-4c8f-ab97-33b3914648d8";
              container = containers."Coding".id;
              url = "https://gitlab.com/quantumfate";
              isEssential = true;
              position = 201;
            };
            "Neovim" = {
              id = "55adc22e-2ee9-44ca-ba19-324264a73f03";
              container = containers."Coding".id;
              url = "https://neovim.io/doc/user/vim_diff.html#nvim-features";
              position = 202;
            };
            "Hyprland" = {
              id = "77af522d-cf23-4d60-bb25-c21e9d7d002e";
              container = containers."Coding".id;
              url = "https://wiki.hypr.land/";
              position = 203;
            };
            "Nix awesome" = {
              id = "d85a9026-1458-4db6-b115-346746bcc692";
              workspace = spaces."Coding".id;
              isGroup = true;
              isFolderCollapsed = false;
              editedTitle = true;
              position = 204;
            };
            "Nix Packages" = {
              id = "f8dd784e-11d7-430a-8f57-7b05ecdb4c77";
              workspace = spaces."Coding".id;
              folderParentId = pins."Nix awesome".id;
              url = "https://search.nixos.org/packages";
              position = 205;
            };
            "Nix Options" = {
              id = "92931d60-fd40-4707-9512-a57b1a6a3919";
              workspace = spaces."Coding".id;
              folderParentId = pins."Nix awesome".id;
              url = "https://search.nixos.org/options";
              position = 206;
            };
            "Home Manager Options" = {
              id = "2eed5614-3896-41a1-9d0a-a3283985359b";
              workspace = spaces."Coding".id;
              folderParentId = pins."Nix awesome".id;
              url = "https://home-manager-options.extranix.com";
              position = 207;
            };
            "Nixpkgs Reference Manual" = {
              id = "2eb4d13d-2da5-429a-952f-55e2af3e0deb";
              workspace = spaces."Coding".id;
              folderParentId = pins."Nix awesome".id;
              url = "https://nixos.org/manual/nixpkgs/unstable/";
              position = 208;
            };
            "ToDo" = {
              id = "48f3d909-64b1-4c06-b799-5a2a62a28d0e";
              workspace = spaces."Coding".id;
              isGroup = true;
              isFolderCollapsed = false;
              editedTitle = true;
              position = 209;
            };
            "Cross-platform Audio Visualizer" = {
              id = "9b2e8c82-dd9e-4974-88bb-3540f1a57ca7";
              workspace = spaces."Coding".id;
              folderParentId = pins."ToDo".id;
              url = "https://github.com/karlstav/cava";
              position = 210;
            };
            "Catppuccin for Anki" = {
              id = "8c5587c1-f375-4a19-89dc-daaa90d0f1cf";
              workspace = spaces."Coding".id;
              folderParentId = pins."ToDo".id;
              url = "https://github.com/catppuccin/anki";
              position = 211;
            };
            "gokcehan/lf - file browser" = {
              id = "e4e2f1fb-dd88-4b7d-92f0-81eca1e9d949";
              workspace = spaces."Coding".id;
              folderParentId = pins."ToDo".id;
              url = "https://github.com/gokcehan/lf";
              position = 212;
            };
            "Quickshell" = {
              id = "20964168-4b62-455a-95e3-4b66c1f243d1";
              workspace = spaces."Coding".id;
              folderParentId = pins."ToDo".id;
              url = "https://quickshell.org/";
              position = 213;
            };
            "Vladimir-csp/uwsm" = {
              id = "8d9fcedf-d73b-437e-9907-bccae537eaab";
              workspace = spaces."Coding".id;
              folderParentId = pins."ToDo".id;
              url = "https://github.com/Vladimir-csp/uwsm";
              position = 214;
            };
            "ING" = {
              id = "5384d853-1e3c-4e73-9230-245db92f3422";
              workspace = spaces."Finance".id;
              url = "https://www.ing.de/";
              position = 300;
            };
            "Revolut" = {
              id = "836f5429-f44a-4eed-bca6-6fdf749fc67f";
              workspace = spaces."Finance".id;
              url = "https://app.revolut.com/home";
              position = 301;
            };
            "Skrill" = {
              id = "be391412-8169-4d13-9aa3-1c3334d8e9e4";
              workspace = spaces."Finance".id;
              url = "https://www.skrill.com/de/";
              position = 302;
            };
            "ProtonDB" = {
              id = "6387399d-67f4-4476-a5ba-fd120e5d2238";
              workspace = spaces."Gaming".id;
              url = "https://www.protondb.com/";
              position = 400;
            };
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
          pins = {
            "Dofus Pour Les Noobs" = {
              id = "c492119b-af85-46f9-b061-84776739f59a";
              container = containers."Dofus".id;
              url = "https://www.dofuspourlesnoobs.com/";
              isEssential = true;
              position = 100;
            };
            "DofusDB" = {
              id = "78bcb1f2-c9da-42e3-8322-89ccc4b592ee";
              container = containers."Dofus".id;
              url = "https://dofusdb.fr/en";
              isEssential = true;
              position = 101;
            };
            "Dofusbook" = {
              id = "f5ea6d21-e8e1-45d5-a103-29cefec482ab";
              container = containers."Dofus".id;
              url = "https://www.dofusbook.net/en/";
              isEssential = true;
              position = 102;
            };
            "Dofensive" = {
              id = "fe19b678-294b-45ac-8cda-0c040fa81399";
              container = containers."Dofus".id;
              url = "https://dofensive.com/en/";
              isEssential = true;
              position = 103;
            };
            "Barbofus" = {
              id = "1d83d41e-ea2e-42c2-8974-d31ce52b3f85";
              container = containers."Dofus".id;
              url = "https://barbofus.com/";
              position = 104;
            };
            "Job XP" = {
              id = "6c2e73f2-da14-4d87-93f4-3f700c13a795";
              container = containers."Dofus".id;
              url = "https://dofusdb.fr/en/tools/jobs-xp";
              position = 105;
            };
            "Treasure Hunt" = {
              id = "be9a7c42-4754-4bf2-b01d-0cd8c7dae340";
              container = containers."Dofus".id;
              url = "https://dofusdb.fr/en/tools/treasure-hunt";
              position = 106;
            };
          };
        };
      };
    };
  };
}
