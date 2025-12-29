{ config, ... }:

let
  userCfg = config.common.user;
in {
  home-manager.users."${userCfg.name}" = {
    programs.ssh = {
      enable = true;
      extraConfig = ''
        Host github.com
          HostName github.com
          User git
          IdentityFile ~/.ssh/github
          IdentitiesOnly yes
          AddKeysToAgent yes
        Host gitlab.com
          HostName gitlab.com
          User git
          IdentityFile ~/.ssh/gitlab
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
