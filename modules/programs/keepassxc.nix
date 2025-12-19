{ config, pkgs, lib, ... }:

let
  userCfg = config.common.user;
  mkNativeMessagingHost = browser:
    {
      name = "org.keepassxc.keepassxc_browser";
      description = "KeePassXC integration with native messaging support";
      path = "${pkgs.keepassxc}/bin/keepassxc-proxy";
      type = "stdio";
    } // (if browser == "firefox" then {
      allowed_extensions = [ "keepassxc-browser@keepassxc.org" ];
    } else {
      allowed_origins =
        [ "chrome-extension://oboonakemofpalcgghocfoadofidjkkk/" ];
    });

  native_messaging_hosts = {
    ".config/BraveSoftware/Brave-Browser/NativeMessagingHosts/org.keepassxc.keepassxc_browser.json".text =
      builtins.toJSON (mkNativeMessagingHost "brave");
    ".config/google-chrome/NativeMessagingHosts/org.keepassxc.keepassxc_browser.json".text =
      builtins.toJSON (mkNativeMessagingHost "chrome");
    ".mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json".text =
      builtins.toJSON (mkNativeMessagingHost "firefox");
  };
in {

  home-manager.users."${userCfg.name}" = {
    home.file = native_messaging_hosts;
    programs.keepassxc = {
      enable = true;
      settings = {
        General = {
          RememberLastDatabases = true;
          RememberLastKeyFiles = true;
          OpenPreviousDatabasesOnStartup = true;
          AutoSaveAfterEveryChange = true;
          LastActiveDatabase =
            "/home/${userCfg.name}/Documents/Keepass/privatepw_final.kdbx";
          LastDatabases =
            "/home/${userCfg.name}/Documents/Keepass/privatepw_final.kdbx";
          LastOpenedDatabases =
            "/home/${userCfg.name}/Documents/Keepass/privatepw_final.kdbx";
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
          EnabledFirefox = true;
          AlwaysAllowAccess = true;
          UpdateBinaryPath = false;
          UseCustomBrowser = true;
          CustomBrowserType = -1; # Firefox
          CustomBrowserLocation = "~/.mozilla/native-messaging-hosts";
        };
      };
    };
  };
}
