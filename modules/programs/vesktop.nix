{ config, ... }:

let 
  userCfg = config.common.user;
  catppuccin = config.theme.catppuccin;
in {

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
