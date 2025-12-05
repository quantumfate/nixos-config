{ config, ... }:

let userCfg = config.common.user;
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
        appBadge = false;
        disableMinSize = true;
        checkUpdates = true;
        clickTrayToShowHide = false;
        customTitleBar = false;

        enableSplashScreen = true;
        splashTheming = true;
        splashColor = "#ffffff";
        splashBackground = "#000000";
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
          };
        };
        themes = [
          "@import url('https://catppuccin.github.io/discord/dist/catppuccin-${config.common.style.catppuccin.flavor}-${config.common.style.catppuccin.accent}.theme.css');"
        ];
      };
    };
  };
}
