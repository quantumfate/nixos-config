{ config, pkgs, ... }:

{
  home.username = "quantum";
  home.homeDirectory = "/home/quantum";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  programs.bash = {
    enable = true;
    shellAliases = { btw = "echo i use hyprland btw"; };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec hyprland
      fi
    '';
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Leon Connor Holm";
        email = "leonconnorholm@gmail.com";
      };
    };
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        HostName github.com
        User git
        IdentityFile ~/.ssh/github
        IdentitiesOnly yes
        AddKeysToAgent yes
        UseKeychain yes
    '';
    enableDefaultConfig = false;
    matchBlocks."*" = {
      forwardAgent = false;
      addKeysToAgent = "no";
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };
  };
  home.packages = [ ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, F, exec, brave"
        "$mod, R, exec, rofi -show run"
        "$mod, X, killactive"
      ];

      bindm = [ "ALT, mouse:272, movewindow" ];
    };
  };
  home.file = {

  };

  home.sessionVariables = { EDITOR = "vim"; };

  services.udiskie = {
    enable = true;
    automount = true;
  };

  programs.home-manager.enable = true;
}
