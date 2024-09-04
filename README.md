# New Installations

## NIXOS Configuration

***Filesystem*** - BTRFS (for snapshots)

/boot - fat32 - 512MiB - flags = boot, esp - name = EFI

/ - btrfs - remaining space - flags = (none) - name = root

***1) Run installation script:***

1) `wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/install-server.sh`
2) `chmod 755 install-server.sh`
3) `./install-server.sh`

***To rebuild after making changes to configurations:***

`sudo nixos-rebuild switch`

***To update channels:***

`sudo nix-channel --update`

***To upgrade system:***

`sudo nixos-rebuild switch --upgrade`

***To delete old versions of os:***
```
sudo nix-collect-garbage --delete-older-than 1d
sudo nix-collect-garbage -d
sudo nixos-rebuild boot
```

######################################################################
## NUbuntu Configuration (NIX + Ubuntu)

***To download installation script:***
```
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/distros/ubuntu/desktop/ubuntu-desktop-install.sh
```

***To rebuild after making changes to flake.nix/configuration:***
```
nix flake update
nix build .#homeConfigurations.developer.activationPackage
nix run .#homeConfigurations.developer.activationPackage
```

***To rebuild after making changes to home.nix:***
`nix run nixpkgs#home-manager -- switch`

######################################################################

## Dotfiles & SSH Keys

***To sync chezmoi (dotfiles) to another machine:***
`chezmoi init --apply majordomo-systems/dotfiles`

***Create a configuration file for chezmoi:***
`pico /.config/chezmoi/chezmoi.toml`

***add this into chezmoi.toml:***
```
encryption = "age"
merge.command = "nvim"
merge.args = ["-d"]

[age]
    identity = "~/.ssh/age_key.txt"
```
***Decrypt Age Key:***
`age -d -o ~/.ssh/age_key.txt ~/.ssh/age_key.txt.enc`

***Password Hint:***

The street you grew up on (begins with B - all lowercase).

***Sync chezmoi a second time to pull ssh keys***
`chezmoi apply`

### Age Key Information

***Age Key was encrypted using:***
`age -p -o ~/.ssh/age_key.txt.enc ~/.ssh/age_key.txt`

***Age Key can be decrypted using:***
`age -d -o ~/.ssh/age_key.txt ~/.ssh/age_key.txt.enc`

######################################################################

1. [Managing your NixOS configuration with Flakes and Home Manager!](https://josiahalenbrown.substack.com/p/managing-your-nixos-configuration)