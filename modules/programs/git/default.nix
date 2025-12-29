{ config, ... }:

let userCfg = config.common.user;
in {

  home-manager.users."${userCfg.name}" = {
    home.file = {
      ".config/git/githubconf".source = ./githubconf;
      ".config/git/gitlabconf".source = ./gitlabconf;
    };
    programs.git = {
      enable = true;
      settings = {
        user = { name = "Leon Connor Holm"; };
        "includeIf \"gitdir:~/projects/github/\"" = {
          path = "~/.config/git/githubconf";
        };
        "includeIf \"gitdir:~/projects/gitlab/\"" = {
          path = "~/.config/git/gitlabconf";
        };
        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };
  };
}
