# nix flake update
# nix build .#homeConfigurations.admin.activationPackage
# nix run .#homeConfigurations.admin.activationPackage
{
  description = "Home Manager configuration of admin";

  inputs = {
    # Specify the source of Home Manager, Nixpkgs, and Catppuccin.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { nixpkgs, home-manager, catppuccin, ... }:
    let
      system = "aarch64-linux";  # Adjust this to your system if needed
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."admin" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
          catppuccin.homeManagerModules.catppuccin
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
