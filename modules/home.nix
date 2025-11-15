{ config, pkgs, lib, inputs, ... }:

let userCfg = config.common.user;
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.${userCfg.name} = {
      home.packages = with pkgs; [
        # Ricing
        catppuccin-kvantum
        waybar
        rofi
        npins
        (catppuccin-kvantum.override {
          accent = "teal";
          variant = "mocha";
        })
        libsForQt5.qtstyleplugin-kvantum
        libsForQt5.qt5ct
        papirus-folders

        ## Formatters
        nixfmt-classic

        ## Office
        anki
        obsidian

        ## Tools
        networkmanagerapplet
        pavucontrol
        pamixer
        obs-studio
        mpv
        keepassxc
        udiskie
        udisks2
        gimp

        ## Media
        discord
        spotify

        ## Programming
        vscode
        python3
        neovim

        ## Terminal
        ranger
        foot
        kitty
        alacritty
        jq
        neofetch
        zathura

        (callPackage (../Packages/ankama-launcher.nix) {})
        ydotool
      ];
      imports = [
        {
          home.username = "${userCfg.name}";
          home.homeDirectory = "/home/${userCfg.name}";
          home.stateVersion = "25.05";
          programs.home-manager.enable = true;
        }
        inputs.catppuccin.homeModules.catppuccin
      ];
    };
  };
}
