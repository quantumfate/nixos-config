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
        #catppuccin-kvantum
        waybar
        rofi
        npins
        catppuccin-qt5ct
        catppuccin-cursors.mochaTeal
        (catppuccin-kvantum.override {
          accent = config.common.style.catppuccin.accent;
          variant = config.common.style.catppuccin.flavor;
        })
        (catppuccin-papirus-folders.override {
          accent = config.common.style.catppuccin.accent;
          flavor = config.common.style.catppuccin.flavor;
        })
        (catppuccin-sddm.override {
          flavor = config.common.style.catppuccin.flavor;
          font = config.common.style.fontFamily;
          fontSize = "12";
        })
        lxqt.pavucontrol-qt
        papirus-folders

        ## Formatters
        nixfmt-classic

        ## Office
        anki
        obsidian

        ## Tools
        networkmanagerapplet
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

        #(callPackage (../Packages/ankama-launcher.nix) { })
        ankama-launcher
        ydotool
        xdotool
        socat
      ];
      imports = [
        {
          home.username = "${userCfg.name}";
          home.homeDirectory = "/home/${userCfg.name}";
          home.stateVersion = "25.05";
          programs.home-manager.enable = true;
        }
        inputs.catppuccin.homeModules.catppuccin
        inputs.stylix.homeModules.stylix
      ];
    };
  };
}
