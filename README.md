# NIXOS Configuration

## For NIXos Systems:

***Add these channel first:***

```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
sudo nix-channel --add https://github.com/catppuccin/nix/archive/main.tar.gz catppuccin
sudo nix-channel --update

```

***To rebuild after making changes to configurations:***

```
sudo nixos rebuild-switch
```

***To delete old versions of os:***

```
sudo nix-collect-garbage --delete-older-than 1d
sudo nix-collect-garbage -d
sudo nixos rebuild-boot
```

######################################################################

## For Ubuntu & NIX Systems:

***To rebuild after making changes to flake.nix/configuration:***

```
nix flake update
nix build .#homeConfigurations.developer.activationPackage
nix run .#homeConfigurations.developer.activationPackage
```

***To rebuild after making changes to home.nix:***

```
nix run nixpkgs#home-manager -- switch
```

######################################################################

1. [Managing your NixOS configuration with Flakes and Home Manager!](https://josiahalenbrown.substack.com/p/managing-your-nixos-configuration)