{ config, ... }:

let userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {
    programs.keepassxc = {
      enable = true;
      settings = {
        General = {
          RememberLastDatabases = true;
          RememberLastKeyFiles = true;
          OpenPreviousDatabasesOnStartup = true;
          AutoSaveAfterEveryChange = true;
          LastActiveDatabase =
            "/home/${userCfg.name}/Documents/Keepass/Keepass/privatepw_final.kdbx";
          LastDatabases =
            "/home/${userCfg.name}/Documents/Keepass/Keepass/privatepw_final.kdbx";
          LastOpenedDatabases =
            "/home/${userCfg.name}/Documents/Keepass/Keepass/privatepw_final.kdbx";
        };
        GUI = {
          ApplicationTheme = "classic";
          MinimizeOnClose = true;
          MinimizeToTray = true;
          ShowTrayIcon = true;
          TrayIconAppearance = "monochrome-dark";
          CheckForUpdates = false;
          ColorPasswords = true;
        };
        Security = {
          ClearClipboardTimeout = 15;
          IconDownloadFallback = true;
        };
        Browser = {
          Enabled = true;
          AlwaysAllowAccess = true;
          UpdateBinaryPath = false;
        };
      };
    };
  };
}
