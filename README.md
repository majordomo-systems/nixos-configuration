## NIXOS Configuration

### Install Home Manager

1. Add the channel first:

```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
sudo nix-channel --add https://github.com/catppuccin/nix/archive/main.tar.gz catppuccin
sudo nix-channel --update

```

# nix flake update
# nix build .#homeConfigurations.developer.activationPackage
# nix run .#homeConfigurations.developer.activationPackage
# nix run nixpkgs#home-manager -- switch

[Managing your NixOS configuration with Flakes and Home Manager!](https://josiahalenbrown.substack.com/p/managing-your-nixos-configuration)