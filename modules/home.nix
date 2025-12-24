{ config, pkgs, lib, inputs, ... }:

let
  userCfg = config.common.user;
  protonmail-desktop-fix = prev.protonmail-desktop.overrideAttrs (oldAttrs: {
    postInstall = (oldAttrs.postInstall or "") + ''
      sed -i \
        's|^Exec=proton-mail %U$|Exec=env XDG_SESSION_TYPE=x11 proton-mail %U|' \
        usr/share/applications/proton-mail.desktop
    '';
  });
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.${userCfg.name} = {
      home.packages = with pkgs;
        [
          # Ricing
          papirus-folders
          #papirus-icon-theme

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
          whatsapp-electron
          signal-desktop
          wiremix
          qalculate-qt
          proton-pass
          protonmail-desktop-fix

          #          (callPackage (../Packages/ankama-launcher.nix) { })
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
