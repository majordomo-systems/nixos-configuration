{
  inputs = {
    systems.url = "github:nix-systems/default";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
  {
    self,
    nixpkgs,
    systems,
  }:
  let
    forEachSystem =
      f: nixpkgs.lib.genAttrs (import systems) (system: f {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      });
  in
  {
    devShells = forEachSystem (
      { pkgs }:
      {
        default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            ########################################################################################
            ######################################################################################## 
            # Javascript
            ########################################################################################
            ######################################################################################## 
            nodenv
            nodejs
            nodePackages.npm
            nodePackages.pnpm
            electron
            ########################################################################################
            ######################################################################################## 
            # Python
            ########################################################################################
            ######################################################################################## 
            python3
            
            # Python Packages
            (python.withPackages (ps: with ps;
            [
              # Django
              django
              djangorestframework
              djangorestframework-simplejwt

              # API Development
              fastapi
              pydantic

              # Testing
              pytest
              pytest-django
            ]))
            ########################################################################################
            ######################################################################################## 
            # Go
            ########################################################################################
            ######################################################################################## 
            go
            hugo
            ########################################################################################
            ######################################################################################## 
            # Cloud CLI
            ########################################################################################
            ######################################################################################## 
            firebase-tools
            ibmcloud-cli
            azure-cli
            awscli2
            ########################################################################################
            ######################################################################################## 
            # Development Environments
            ########################################################################################
            ########################################################################################
            # vscode # Visual Studio Code: A lightweight, extensible, and cross-platform IDE by Microsoft.
            # jetbrains.datagrip # DataGrip: Database IDE for working with multiple databases.
            # jetbrains.goland # GoLand: Go IDE from JetBrains.
            # jetbrains.phpstorm # PHPStorm: PHP IDE from Jetbrains.
            # jetbrains.rider # Ridedr: .NET IDE from JetBrains.
            # jetbrains.ruby-mine # Ruby Mine: Ruby IDE from Jetbrains.
          ];

          # VSCode extension installation
          # shellHook = ''
          #   mkdir -p .vscode/extensions
          #   code --install-extension catppuccin.catppuccin-vsc --force
          #   # Add more extensions here as needed
          # '';
        };
      }
    );
  };
}
