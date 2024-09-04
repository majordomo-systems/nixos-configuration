#!/bin/bash

# INITIAL CLEANUP
cd ~/
rm -Rf Music Pictures Videos Templates

# ADD CHANNELS
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
sudo nix-channel --add https://github.com/catppuccin/nix/archive/main.tar.gz catppuccin
sudo nix-channel --update

# CLONE CONFIGURATION
cd /etc/nixos
sudo nix --extra-experimental-features nix-command --extra-experimental-features flakes run nixpkgs@git -- clone https://github.com/majordomo-systems/nixos-configuration.git
sudo rm /etc/nixos/configuration.nix
sudo rm /etc/nixos/nixos-configuration/configuraton.nix
sudo rm /etc/nixos/nixos-configuration/users.nix
cd nixos-configuration
sudo mv configuration-server.nix configuration.nix
sudo mv users-server.nix users.nix
sudo cp -r .[!.]* * ../
cd ..
sudo rm -Rf nixos-configuration

# Prompt the user for a hostname
read -p "Please enter a hostname for this device: " hostname

# Replace the word 'nixos' in network.nix with the entered hostname
sed -i "s/nixos/$hostname/g" network.nix

# Confirmation message
echo "The hostname has been updated to '$hostname' in network.nix."

# REBUILD CONFIGURATION
sudo nixos-rebuild switch

####################################################################################

# Initialize chezmoi
chezmoi init --apply majordomo-systems/dotfiles

# Create chezmoi configuration file
tee ~/.config/chezmoi/chezmoi.toml > /dev/null << EOF
encryption = "age"
merge.command = "nvim"
merge.args = ["-d"]

[age]
    identity = "~/.ssh/age_key.txt"
EOF

# Decrypt Age Key - password hint: the street you grew up on
age -d -o ~/.ssh/age_key.txt ~/.ssh/age_key.txt.enc

# Apply chezmoi configuration
chezmoi apply