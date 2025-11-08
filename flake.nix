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
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      mainUser = "quantum";
      mkSystem = { configNix }: {
        specialArgs = { inherit inputs; };
        modules = [
          (import configNix)
          inputs.home-manager.nixosModules.home-manager
          inputs.catppuccin.nixosModules.catppuccin
        ];
      };
    in {
      nixosConfigurations.quantum-desktop = nixpkgs.lib.nixosSystem
        (mkSystem { configNix = ./hosts/quantum-desktop/configuration.nix; });
      
      # todo add laptop
    };
}
