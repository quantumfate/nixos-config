{ config, ... }:

let
  userCfg = config.common.user;
  catppuccin = config.theme.catppuccin;
in {
  # https://github.com/NixOS/nixpkgs/issues/476669#issuecomment-3707850520
  nixpkgs.overlays = [
    (final: prev: {
      vesktop = prev.vesktop.overrideAttrs (old: {
        preBuild = ''
          cp -r ${prev.electron.dist} electron-dist
          chmod -R u+w electron-dist
        '';
        buildPhase = ''
          runHook preBuild

          pnpm build
          pnpm exec electron-builder \
            --dir \
            -c.asarUnpack="**/*.node" \
            -c.electronDist="electron-dist" \
            -c.electronVersion=${prev.electron.version}

          runHook postBuild
        '';
      });
    })
  ];
  home-manager.users."${userCfg.name}" = {
    programs.vesktop = {
      enable = true;
      settings = {
        discordBranch = "stable";
        transparencyOptien = "acrylic";
        tray = true;
        minimizeToTray = true;
        autoStartMinimized = false;
        openLinksWithElectron = false;
        staticTitle = false;
        enableMenu = true;
        disableSmoothScroll = false;
        hardwareAcceleration = true;
        hardwareVideoAcceleration = true;
        arRPC = true;
        appBadge = true;
        disableMinSize = true;
        checkUpdates = true;
        clickTrayToShowHide = false;
        customTitleBar = false;

        enableSplashScreen = true;
        splashTheming = true;
        splashColor = "${catppuccin.hex.text}";
        splashBackground = "${catppuccin.hex.base}";
        splashPixelated = true;

        spellCheckLanguages = [ "EN" "DE" ];

      };
      vencord = {
        settings = {
          autoUpdate = true;
          autoUpdateNotification = false;
          notifyAboutUpdates = false;
          useQuickCss = true;
          disableMinSize = true;
          plugins = {
            MessageLogger = {
              enabled = true;
              ignoreSelf = true;
            };
            CustomRPC.enabled = true;
            MessageTags.enabled = true;
            NoF1.enabled = true;
            NoReplyMention.enabled = true;
            OpenInApp.enabled = true;
            PreviewMessage.enabled = true;
            ReadAllNotificationsButton.enabled = true;
            ReplaceGoogleSearch.enabled = true;
            ReverseImageSearch.enabled = true;
            Translate.enabled = true;
            YoutubeAdblock.enabled = true;
            WebRichPresence.enabled = true;
          };
        };
      };
    };
  };
}
