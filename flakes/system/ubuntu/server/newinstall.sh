#!/bin/bash

####################################################################################

# CREATE DROPLET:
# Region: Toronto
# Marketplace: Docker
# Type: Basic
# CPU: Premium Intel $7/mo
# Need to have password authentication to ssh
# Authentication Method: SSH Keys
# Server Name: majordomo.systems
# Tags: docker, vscode, n8n

####################################################################################

# CREATE A NEW USER & ADD TO SUDOERS
adduser administrator
usermod -a -G sudo administrator
# usermod -a -G docker administrator
su administrator
cd

# wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/flakes/system/ubuntu/server/ubuntu-server-install.sh

####################################################################################

# DISABLE ROOT LOGIN
# sudo sed -i 's#PermitRootLogin yes#PermitRootLogin no#' /etc/ssh/sshd_config

####################################################################################

# INSTALL SYSTEM SOFTWARE
sudo apt -y update && sudo apt -y upgrade
sudo apt-get -y install build-essential software-properties-common python3-pip fail2ban

####################################################################################

# NIX INSTALLATION
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. /home/admin/.nix-profile/etc/profile.d/nix.sh 
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" | tee -a ~/.config/nix/nix.conf
source ~/.profile
nix run nixpkgs#cowsay Nix Installation Complete!

# NIX CONFIGURATION
cd ~/.config/nix/
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/flakes/system/ubuntu/server/flake.nix
nix flake update
nix build .#homeConfigurations.developer.activationPackage
nix run .#homeConfigurations.developer.activationPackage

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
    recipients = ["age1y6yu9gm325dpt7gccw8z0wrq2zrk9xsf2lr95kcl0a0f77mf5g3shfu2x9"]
EOF

# Decrypt Age Key - password hint: the street you grew up on
age -d -o ~/.ssh/age_key.txt ~/.ssh/age_key.txt.enc

# Apply chezmoi configuration
chezmoi apply