{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    catppuccin.url = "github:catppuccin/nix";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      mkSystem = { configNix, userName }: {
        specialArgs = { inherit inputs; };
        modules = [
          (import configNix)
          inputs.home-manager.nixosModules.home-manager
          inputs.catppuccin.nixosModules.catppuccin
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users."${userName}" = {
                imports = [
                  ./modules/nixos/home.nix
                  inputs.catppuccin.homeModules.catppuccin
                  inputs.nix-colors.homeManagerModules.default
                ];
                colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
              };
            };
          }
        ];
      };
    in {
      nixosConfigurations.quantum-desktop = nixpkgs.lib.nixosSystem (mkSystem {
        configNix = ./hosts/quantum-desktop/configuration.nix;
        userName = "quantum";
      });
    };
}
