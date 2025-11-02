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

  outputs = { self, nixpkgs, nix-colors, ... }@inputs: {
    nixosConfigurations.quantum-desktop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/quantum-desktop/configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.quantum = {
              imports = [
                ./hosts/quantum-desktop/home.nix
                inputs.catppuccin.homeModules.catppuccin
                inputs.nix-colors.homeManagerModules.default
              ];
              colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
            };          
          };
        }
      ];
    };
  };
}
