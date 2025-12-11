{ config, ... }:

let userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = { config, ... }: {
    programs.keepassxc = {
      enable = true;
      settings = {
        General = {
          RememberLastDatabase = true;
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
        };
        Security = {
          ClearClipboardTimeout = 15;
          IconDownloadFallback = true;
        };
        Browser = {
          Enabled = true;
          AlwaysAllowAccess = true;
        };
      };
    };
  };
}
