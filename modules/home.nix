{ config, pkgs, lib, inputs, ... }:

let userCfg = config.mainUser;
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.${userCfg.userName} = {
      home.packages = with pkgs; [
        waybar
        rofi
        npins

        # Formatters
        nixfmt-classic

        # Office
        anki
        obsidian

        # Tools
        networkmanagerapplet
        pavucontrol
        pamixer
        obs-studio
        mpv
        keepassxc
        udiskie
        udisks2
        gimp

        # Media
        discord
        brave
        spotify

        # Programming
        vscode
        python3
        neovim

        # Terminal
        ranger
        foot
        kitty
        alacritty
        jq
        neofetch

        # Hyprland
        hyprpaper
        hypridle
        hyprpicker
        hyprlock
        xdg-desktop-portal-hyprland
      ];
      imports = [
        {
          home.username = "${userCfg.userName}";
          home.homeDirectory = "/home/${userCfg.userName}";
          home.stateVersion = "25.05";
          programs.home-manager.enable = true;
        }
        inputs.catppuccin.homeModules.catppuccin
      ];
    };
  };
}
