#!/bin/bash

# wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/distros/ubuntu/server/ubuntu-server-install.sh

####################################################################################

# DISABLE ROOT LOGIN
# sudo sed -i 's#PermitRootLogin yes#PermitRootLogin no#' /etc/ssh/sshd_config 

# CHANGE OWNERSHIP AND PERMISSIONS OF GITHUB KEY
cd ~/.ssh
sudo chown admin:admin server.digitalocean_key
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

# INSTALL SYSTEM SOFTWARE
sudo apt -y update && sudo apt -y upgrade
sudo apt-get -y install curl wget build-essential software-properties-common python3-pip fail2ban

####################################################################################

# INITIAL CLEANUP & SETUP
cd ~/
rm *
rm -Rf Music Pictures Videos Templates
mkdir git
cd git
git clone git@github.com:majordomo-systems/scraper.git
cd scraper
npm install
cd ~/

# INSTALL WALLPAPER
# cd /usr/share/backgrounds
# sudo wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/assets/M3-MacBook-Pro-Wallpaper-8K.png
# gsettings set org.gnome.desktop.background picture-uri file:////usr/share/backgrounds/M3-MacBook-Pro-Wallpaper-8K.png
# gsettings set org.gnome.desktop.background picture-uri-dark file:////usr/share/backgrounds/M3-MacBook-Pro-Wallpaper-8K.png

####################################################################################

# INSTALL VSCODE
# cd ~/Downloads
# sudo apt -y update && sudo apt -y upgrade
# sudo apt -y install software-properties-common apt-transport-https wget gpg
# wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
# sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
# sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
# sudo apt -y update
# sudo apt -y install code

# INSTALL DOCKER
# cd ~/Downloads
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# echo \
# "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
# $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt update
# sudo apt -y --fix-broken install
# sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose docker-compose-plugin
# sudo usermod -aG docker $USER

# INSTALL GITHUB DESKTOP
# wget https://github.com/shiftkey/desktop/releases/download/release-3.4.3-linux1/GitHubDesktop-linux-arm64-3.4.3-linux1.deb
# sudo dpkg -i GitHubDesktop-linux-arm64-3.4.3-linux1.deb

####################################################################################

# PULL DOCKER CONTAINERS

# RUN NGINX Proxy
docker run -d -p 80:80 -p 443:443 \
    --name nginx-proxy \
    -v /path/to/certs:/etc/nginx/certs:ro \
    -v /etc/nginx/vhost.d \
    -v /usr/share/nginx/html \
    -v /var/run/docker.sock:/tmp/docker.sock:ro \
    jwilder/nginx-proxy
docker run -d \
    --name nginx-proxy-companion \
    -v /path/to/certs:/etc/nginx/certs:rw \
    --volumes-from nginx-proxy \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    jrcs/letsencrypt-nginx-proxy-companion

# RUN VSCode Server
mkdir -p ~/.config
docker run -d --expose 80 -e VIRTUAL_HOST=code.majordomo.systems -e VIRTUAL_PORT=8080 -e LETSENCRYPT_HOST=code.majordomo.systems -e LETSENCRYPT_EMAIL=admin@majordomo.systems --name code-server -e PASSWORD='developer' \
  -v "$HOME/.config:/home/coder/.config" \
  -u "$(id -u):$(id -g)" \
  codercom/code-server:latest

# RUN n8n Server
docker volume create n8n_data
docker run -v /home/admin/git/scraper:/home/node/scraper -e VIRTUAL_HOST=n8n.majordomo.systems -it --rm --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n &

# Create WebSSH2 Connection
# docker run -e VIRTUAL_HOST=shell.majordomo.systems -it --rm --name webssh2 -p 2222:2222 psharkey/webssh2

####################################################################################

# PULL AND CONFIGURE STARTUP FILE FOR CONTAINERS
cd
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/distros/ubuntu/server/ubuntu-server-start.sh && mv ubuntu-server-start.sh start.sh
sudo chmod +x start.sh

# CREATE A SERVICE AND ADD IT TO init.d
sudo echo '
[Unit]
Description=Start Containers
After=network.target

[Service]
ExecStart=/home/admin/start.sh &

[Install]
WantedBy=default.target
' > ~/containers.service

sudo mv containers.service /etc/systemd/system/
sudo chmod +x /etc/systemd/system/containers.service
sudo systemctl daemon-reload
sudo systemctl enable containers.service
sudo systemctl start containers.service

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
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/distros/ubuntu/server/flake.nix
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
EOF

# Decrypt Age Key - password hint: the street you grew up on
age -d -o ~/.ssh/age_key.txt ~/.ssh/age_key.txt.enc

# Apply chezmoi configuration
chezmoi apply

####################################################################################

# exit
# echo "Restarting in ..."
# sleep 1
# echo "5....."
# sleep 1
# echo "4...."
# sleep 1
# echo "3..."
# sleep 1
# echo "2.."
# sleep 1
# echo "1."
# sleep 1
# echo "Bye bye!"
# shutdown -r now