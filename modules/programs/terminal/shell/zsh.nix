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
            source /home/${userCfg.name}/.config/ranger/rangercd.sh
          '';
          zshConfig = lib.mkOrder 1200 ''
            if [ "$TERM" = "xterm-kitty" ]; then
              fastfetch
            fi
            if [ -n "$RANGER_LEVEL" ]; then export PS1="[ranger]$PS1"; fi
          '';
          shellFunctions = lib.mkOrder 550 ''
            update_system() {
              sudo nixos-rebuild switch --flake '/home/${userCfg.name}/nixos-config#${hostName}'
            }

            upgrade_system() {
              sudo nixos-rebuild switch --upgrade --flake '/home/${userCfg.name}/nixos-config#${hostName}'
            }

            cleanup_system() {
              nix-collect-garbage --delete-older-than 14d
            }

            feh_scaled() {
              local width=$(hyprctl -j monitors | jq -r '.[] | select(.focused) | .width')
              local height=$(hyprctl -j monitors | jq -r '.[] | select(.focused) | .height')
              command feh --geometry $((width*80/100))x$((height*80/100)) --scale-down "$@"
            }
          '';
        in lib.mkMerge [ zshSourcing zshConfig shellFunctions ];
        shellAliases = {
          ll = "ls -l";
          cleanup_system = "nix-collect-garbage --delete-older-than 14d";
          ranger = "ranger-cd";
          feh = "feh_scaled";
        };
        profileExtra = ''
          if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
            exec start-hyprland
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
