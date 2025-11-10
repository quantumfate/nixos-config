{ config, pkgs, lib, inputs, ... }:

let userCfg = config.mainUser;
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.${userCfg.userName} = {
      home.packages = with pkgs; [
        alacritty
        anki
        mpv
        obs-studio
        obsidian
        pavucontrol
        ranger
        nixfmt-classic
        discord
        keepassxc
        spotify
        udiskie
        udisks2
        waybar
        foot
        kitty
        rofi
        neovim
        brave
        vscode
        pamixer
        networkmanagerapplet
        python3
        lutris
        npins
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
