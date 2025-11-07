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
        hyprpaper
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
        xdg-desktop-portal
        lutris
        npins
      ];
      imports = [
        {
          home.username = "${userCfg.userName}";
          home.homeDirectory = "/home/${userCfg.userName}";
          home.stateVersion = "25.05";
          programs.home-manager.enable = true;
        }
        inputs.catppuccin.homeModules.catppuccin
        inputs.nix-colors.homeManagerModules.default
      ];
      # Remove nix-colors, it only supports base 16 and removes some of the colors available
      colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
    };
  };
}
