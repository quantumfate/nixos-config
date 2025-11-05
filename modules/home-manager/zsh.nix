{ config, ... }:

let
  hostName = config.networking.hostName;
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      # TODO: make it host dependent and entegrate flake
      update = "sudo nixos-rebuild switch --flake '~/nixos-config#${hostName}' ";
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec hyprland
      fi
    '';

    oh-my-zsh = { # "ohMyZsh" without Home Manager
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
    history.size = 10000;
  };
}
