#!/bin/bash

# wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/distros/ubuntu/desktop/ubuntu-desktop-install.sh

# INSTALL SYSTEM SOFTWARE
sudo apt -y update && sudo apt -y upgrade
sudo apt-get -y install curl build-essential software-properties-common python3-pip alacritty chromium tilix open-vm-tools open-vm-tools-desktop

####################################################################################

# INITIAL CLEANUP
cd ~/
rm -Rf Music Pictures Videos Templates

# INSTALL WALLPAPER
cd /usr/share/backgrounds
sudo wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/M3-MacBook-Pro-Wallpaper-8K.png
gsettings set org.gnome.desktop.background picture-uri file:////usr/share/backgrounds/M3-MacBook-Pro-Wallpaper-8K.png
gsettings set org.gnome.desktop.background picture-uri-dark file:////usr/share/backgrounds/M3-MacBook-Pro-Wallpaper-8K.png

# GNOME TERMINAL - CATPPUCCIN
# open preferences, choose desired theme, font family: FiraMono Code 18
curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v0.3.0/install.py | python3 -

####################################################################################

# INSTALL VSCODE
cd ~/Downloads
sudo apt -y update && sudo apt -y upgrade
sudo apt -y install software-properties-common apt-transport-https wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt -y update
sudo apt -y install code

# INSTALL DOCKER
cd ~/Downloads
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt -y --fix-broken install
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose docker-compose-plugin
sudo usermod -aG docker $USER

# INSTALL GITHUB DESKTOP
wget https://github.com/shiftkey/desktop/releases/download/release-3.4.3-linux1/GitHubDesktop-linux-arm64-3.4.3-linux1.deb
sudo dpkg -i GitHubDesktop-linux-arm64-3.4.3-linux1.deb

####################################################################################

# NIX INSTALLATION
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. /home/developer/.nix-profile/etc/profile.d/nix.sh 
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" | tee -a ~/.config/nix/nix.conf
source ~/.profile
nix run nixpkgs#cowsay Nix Installation Complete!

# NIX HOME MANAGER INSTALLATION
nix run home-manager/master -- init --switch
# To modify nix configuration:
# code /home/developer/.config/home-manager/home.nix
# nix run nixpkgs#home-manager -- switch

# NIX HOME MANAGER CONFIGURATION

nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
nix-channel --add https://github.com/catppuccin/nix/archive/main.tar.gz catppuccin
nix-channel --update
mkdir -p ~/.config/home-manager/apps
cd ~/.config/home-manager/apps
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/applications/bash.ubuntu.nix && mv bash.ubuntu.nix bash.nix
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/applications/nvchad.nix
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/applications/tilix.nix
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/applications/tmux.nix
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/applications/zsh.ubuntu.nix && mv zsh.ubuntu.nix zsh.nix
cd ~/.config/home-manager
rm flake.nix
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/distros/ubuntu/desktop/ubuntu-desktop-flake.nix && mv ubuntu-desktop-flake.nix flake.nix
rm home.nix
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/distros/ubuntu/desktop/ubuntu-desktop-home.nix && mv ubuntu-desktop-home.nix home.nix
nix flake update
nix build .#homeConfigurations.developer.activationPackage
nix run .#homeConfigurations.developer.activationPackage
cd
ln -s .config/home-manager/home.nix .home.nix
nix run nixpkgs#home-manager -- switch

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

####################################################################################

# sudo reboot
