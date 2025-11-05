{ config, pkgs, lib, ... }:

let
  cfg = config.userPrograms.zsh;
  hostName = config.networking.hostName;
  userCfg = config.mainUser;
in {
  options.userPrograms.zsh.enable =
    lib.mkEnableOption "Zsh shell for the user and system.";

  environment.systemPackages = lib.mkIf cfg.enable [ pkgs.zsh ];

  programs.zsh.enable = cfg.enable;

  environment.pathsToLink = lib.mkIf cfg.enable [ "/share/zsh" ];

  users.users.quantum.shell = lib.mkIf cfg.enable pkgs.zsh;

  home-manager.users."${userCfg.userName}" = {
    programs.zsh = {
      enable = cfg.enable;
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
}
