# Nixos flake
{
  description = "Home Manager configuration of daniel";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
    stylix = { 
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors = {
      url = "github:misterio77/nix-colors";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      # pkgs = import nixpkgs { inherit system; config.allowUnfree = true; config.allowBroken = true; };
    in {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
	specialArgs = { inherit inputs;};
        modules = [ 
	  ./nixos/configuration.nix
	  inputs.stylix.nixosModules.stylix 
	];
      };
    };  
}
