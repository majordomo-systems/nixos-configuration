# INSTALL OPEN VM TOOLS
sudo apt -y update && sudo apt -y upgrade
sudo apt-get -y install open-vm-tools open-vm-tools-desktop

####################################################################################
#!/bin/bash

# INSTALL WALLPAPER
cd /usr/share/backgrounds
sudo wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/M3-MacBook-Pro-Wallpaper-8K.png
gsettings set org.gnome.desktop.background picture-uri file:////usr/share/backgrounds/M3-MacBook-Pro-Wallpaper-8K.png
gsettings set org.gnome.desktop.background picture-uri-dark file:////usr/share/backgrounds/M3-MacBook-Pro-Wallpaper-8K.png

# INITIAL CLEANUP
cd ~/
rm -Rf Music Pictures Videos Templates

sudo apt-get -y install curl build-essential software-properties-common python3-pip

# Nix Installation
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. /home/developer/.nix-profile/etc/profile.d/nix.sh 
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" | tee -a ~/.config/nix/nix.conf
source ~/.profile
nix run nixpkgs#cowsay Nix Installation Complete!

# Nix Home Manager Installation
nix run home-manager/master -- init --switch
# To modify nix configuration:
# code /home/developer/.config/home-manager/home.nix
# nix run nixpkgs#home-manager -- switch

####################################################################################

nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
nix-channel --add https://github.com/catppuccin/nix/archive/main.tar.gz catppuccin
nix-channel --update

####################################################################################

mkdir -p ~/.config/home-manager/apps
cd ~/.config/home-manager/apps
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/applications/alacritty.nix
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/applications/bash.nix
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/applications/nnn.nix
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/applications/nvchad.nix
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/applications/tilix.nix
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/applications/tmux.nix
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/applications/zsh.nix

cd ..
rm home.nix

cd
ln -s .config/home-manager/home.nix .home.nix

sudo reboot
