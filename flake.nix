{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprshutdown.url = "github:hyprwm/hyprshutdown";
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
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    my-zen-config = { url = "git+ssh://git@gitlab.com/my-nixos-config/zen"; };

  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      mkSystem = { configNix }: {
        specialArgs = { inherit inputs system; };
        modules = [
          (import configNix)
          inputs.home-manager.nixosModules.home-manager
          inputs.catppuccin.nixosModules.catppuccin
          inputs.stylix.nixosModules.stylix
          inputs.spicetify-nix.nixosModules.spicetify
        ];
      };
    in {
      nix.settings = {
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        ];
      };
      nixosConfigurations.quantum-desktop = nixpkgs.lib.nixosSystem
        (mkSystem { configNix = ./hosts/quantum-desktop/configuration.nix; });
      nixosConfigurations.quantum-laptop = nixpkgs.lib.nixosSystem
        (mkSystem { configNix = ./hosts/quantum-laptop/configuration.nix; });
    };
}
