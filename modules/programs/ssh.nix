{ config, lib, ... }:

let
  cfg = config.userPrograms.ssh;
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
in {
  options.userPrograms.ssh.enable lib.mkEnableOption "SSH configuration for the user.";
  home-manager.users."${userCfg.userName}" = {
    programs.ssh = {
      enable = cfg.enable;
      extraConfig = ''
        Host github.com
          HostName github.com
          User git
          IdentityFile ~/.ssh/github
          IdentitiesOnly yes
          AddKeysToAgent yes
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
  };
}
