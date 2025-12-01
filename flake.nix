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
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grim-hyprland = {
      url = "github:eriedaberrie/grim-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      mkSystem = { configNix }: {
        specialArgs = { inherit inputs system; };
        modules = [
          (import configNix)
          inputs.home-manager.nixosModules.home-manager
          inputs.catppuccin.nixosModules.catppuccin
          inputs.stylix.nixosModules.stylix
        ];
      };
    in {
      nixosConfigurations.quantum-desktop = nixpkgs.lib.nixosSystem
        (mkSystem { configNix = ./hosts/quantum-desktop/configuration.nix; });
      nixosConfigurations.quantum-laptop = nixpkgs.lib.nixosSystem
        (mkSystem { configNix = ./hosts/quantum-laptop/configuration.nix; });
    };
}
