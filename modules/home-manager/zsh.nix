{
  programs.zsh = {
  enable = true;
  enableCompletions = true;
  autosuggestions.enable = true;
  syntaxHighlighting.enable = true;

  shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";
  };
  oh-my-zsh = { # "ohMyZsh" without Home Manager
    enable = true;
    plugins = [ "git" "thefuck" ];
    theme = "robbyrussell";
  };
  history.size = 10000;
};
}