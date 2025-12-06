{ config, pkgs, lib, inputs, ... }:

let userCfg = config.common.user;
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.${userCfg.name} = {
      home.packages = with pkgs;
        [
          # Ricing
          lxqt.pavucontrol-qt
          papirus-folders

          ## Formatters
          nixfmt-classic
          nixd
          shfmt

          ## Office
          anki
          obsidian

          ## Tools
          networkmanagerapplet
          pamixer
          obs-studio
          mpv
          gimp

          ## Programming
          vscode
          python3
          neovim

          ## Terminal
          zathura

          #(callPackage (../Packages/ankama-launcher.nix) { })
          
          keepassxc
          obs-studio
        ] ++ lib.optionals config.common.modules.dofus.enable
        [ pkgs.ankama-launcher ] ++ config.common.user.packages;
      imports = [
        {
          home.username = "${userCfg.name}";
          home.homeDirectory = "/home/${userCfg.name}";
          home.stateVersion = "25.11";
          programs.home-manager.enable = true;
        }
        inputs.catppuccin.homeModules.catppuccin
        inputs.stylix.homeModules.stylix
      ];
    };
  };
}
