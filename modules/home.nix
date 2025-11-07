{ config, pkgs, lib, inputs, ... }:

let userName = config.users.mainUser;
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.${userName} = {
      imports = [
        {
          home.username = "${userName}";
          home.homeDirectory = "/home/${userName}";
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
