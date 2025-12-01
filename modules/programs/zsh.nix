{ config, pkgs, lib, ... }:

let
  hostName = config.networking.hostName;
  userCfg = config.common.user;
in {

  config = {
    environment.systemPackages = with pkgs; [ zsh ];

    programs.zsh.enable = true;

    environment.pathsToLink = [ "/share/zsh" ];

    home-manager.users."${userCfg.name}" = {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        initContent = let
          zshSourcing = lib.mkOrder 500 ''
            source = /home/${userCfg.name}/.config/ranger/rangercd.sh
          '';
          zshConfig = lib.mkOrder 1200 ''
            neofetch
            if [ -n "$RANGER_LEVEL" ]; then export PS1="[ranger]$PS1"; fi
          '';
        in lib.mkMerge [ zshSourcing zshConfig ];
        shellAliases = {
          ll = "ls -l";
          update_system =
            "sudo nixos-rebuild switch --flake '/home/${userCfg.name}/nixos-config#${hostName}' ";
          upgrade_system =
            "sudo nixos-rebuild switch --upgrade --flake '/home/${userCfg.name}/nixos-config#${hostName}' ";

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
