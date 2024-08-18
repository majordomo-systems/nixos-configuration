#!/bin/bash

####################################################################################

# DISABLE ROOT LOGIN
# sudo sed -i 's#PermitRootLogin yes#PermitRootLogin no#' /etc/ssh/sshd_config 

# CHANGE OWNERSHIP AND PERMISSIONS OF GITHUB KEY
cd ~/.ssh
sudo chown developer:developer server.digitalocean_key
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

# CLEANUP & CREATE ENVIRONMENT
cd
wget https://majordomo-dotfiles.web.app/gitconfig && mv gitconfig .gitconfig
wget https://majordomo-dotfiles.web.app/gitignore && mv gitignore .gitignore
wget https://majordomo-dotfiles.web.app/gitignore_global && mv gitignore_global .gitignore_global
rm *
mkdir git
cd git
git clone git@github.com:majordomo-systems/scraper.git
cd scraper
npm install
cd

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
docker run -v /home/developer/git/scraper:/home/node/scraper -e VIRTUAL_HOST=n8n.majordomo.systems -it --rm --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n &

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
ExecStart=/home/developer/start.sh &

[Install]
WantedBy=default.target
' > ~/containers.service

sudo mv containers.service /etc/systemd/system/
sudo chmod +x /etc/systemd/system/containers.service
sudo systemctl daemon-reload
sudo systemctl enable containers.service
sudo systemctl start containers.service

####################################################################################

exit
echo "Restarting in ..."
sleep 1
echo "5....."
sleep 1
echo "4...."
sleep 1
echo "3..."
sleep 1
echo "2.."
sleep 1
echo "1."
sleep 1
echo "Bye bye!"
shutdown -r now

####################################################################################
