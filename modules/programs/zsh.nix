{ config, pkgs, lib, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common;
in {

  config = {
    environment.systemPackages = with pkgs; [ zsh ];

    programs.zsh.enable = true;

    environment.pathsToLink = [ "/share/zsh" ];

    home-manager.users."${userCfg.userName}" = {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
          ll = "ls -l";
          update_system =
            "sudo nixos-rebuild switch --flake '~/nixos-config#${hostName}' ";
          upgrade_system =
            "sudo nixos-rebuild switch --upgrade --flake '~/nixos-config#${hostName}' ";

        };
        profileExtra = ''
          if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
            exec hyprland
          fi
        '';

        oh-my-zsh = {
          enable = true;
          plugins = [ "git" ];
          theme = "robbyrussell";
        };
        history.size = 10000;
      };
    };
  };
}
