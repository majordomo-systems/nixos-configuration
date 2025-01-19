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

# CREATE AND SETUP A NEW USER
adduser administrator
usermod -a -G sudo administrator
# usermod -a -G docker administrator
su administrator
cd
mkdir Downloads

####################################################################################

# DOWNLOAD INSTALLATION SCRIPT
cd Downloads
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/flakes/system/ubuntu/server/ubuntu-server-install.sh

####################################################################################

# DISABLE ROOT LOGIN
# sudo sed -i 's#PermitRootLogin yes#PermitRootLogin no#' /etc/ssh/sshd_config

####################################################################################

# INSTALL SYSTEM SOFTWARE
sudo apt -y update && sudo apt -y upgrade
sudo apt-get -y install build-essential software-properties-common python3-pip fail2ban

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

####################################################################################

# NIX INSTALLATION
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. /home/administrator/.nix-profile/etc/profile.d/nix.sh 
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" | tee -a ~/.config/nix/nix.conf
source ~/.profile
nix run nixpkgs#cowsay Nix Installation Complete!

# NIX CONFIGURATION
cd ~/.config/nix/
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/flakes/system/ubuntu/server/flake.nix
nix flake update
nix build .#homeConfigurations.administrator.activationPackage
nix run .#homeConfigurations.administrator.activationPackage

####################################################################################

# Set ZSH as Default Shell
echo "/home/administrator/.nix-profile/bin/zsh" | sudo tee -a /etc/shells
chsh -s $(which zsh)

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

####################################################################################

# CHANGE OWNERSHIP AND PERMISSIONS OF GITHUB KEY
cd ~/.ssh
sudo chmod 600 server.digitalocean_key
cd

# START SSH AGENT
eval `ssh-agent -s`

# ADD GITHUB KEY TO SSH AGENT
ssh-add ~/.ssh/server.digitalocean_key

# Create and display new SSH Key
ssh-keygen -t ed25519 -C "majordomo.systems"
cat ~/.ssh/id_ed25519.pub

# START SSH AGENT
eval `ssh-agent -s`

# ADD NEW KEY TO SSH AGENT
ssh-add ~/.ssh/id_ed25519

####################################################################################

# PULL AND CONFIGURE STARTUP FILE FOR CONTAINERS
cd
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/docker-start.sh
sudo chmod +x docker-start.sh

# CREATE A SERVICE AND ADD IT TO init.d
sudo echo '
[Unit]
Description=Start Containers
After=network.target

[Service]
ExecStart=/home/administrator/docker-start.sh &

[Install]
WantedBy=default.target
' > ~/containers.service

sudo mv containers.service /etc/systemd/system/
sudo chmod +x /etc/systemd/system/containers.service
sudo systemctl daemon-reload
sudo systemctl enable containers.service
sudo systemctl start containers.service