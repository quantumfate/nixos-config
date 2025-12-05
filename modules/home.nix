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
          udiskie
          udisks2
          gimp

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
          ydotool
          xdotool
          socat
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
