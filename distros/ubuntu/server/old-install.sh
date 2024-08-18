# CREATE DROPLET:
# Region: Toronto
# Marketplace: Docker
# Type: Basic
# CPU: Premium Intel $7/mo
# Need to have password authentication to ssh
# Authentication Method: SSH Keys
# Server Name: majordomo.systems
# Tags: docker, vscode, n8n
#############################################################################################################################################

# FIRST CREATE A NEW USER & ADD TO SUDOERS
#!/bin/bash
adduser developer
usermod -a -G sudo developer
usermod -a -G docker developer
su developer
cd
# SSH CONFIGURATION
mkdir .ssh
# LOGOUT OF DEVELOPER
exit
# LOGOUT OF DROPLET
exit
# COPY SSH KEY FROM LOCAL TO DROPLET
scp server.digitalocean_key root@68.183.194.146:/home/developer/.ssh/
# LOG BACK INTO DROPLET
ssh root@68.183.194.146
su developer

# Disable root login
# sudo sed -i 's#PermitRootLogin yes#PermitRootLogin no#' /etc/ssh/sshd_config 

#############################################################################################################################################
# THIS IS THE MAIN INSTALLATION SCRIPT
#!/bin/bash

# CHANGE OWNERSHIP AND PERMISSIONS OF KEY
cd ~/.ssh
sudo chown developer:developer server.digitalocean_key
sudo chmod 600 server.digitalocean_key
# Start SSH Agent
eval `ssh-agent -s`
# Add new key to SSH Agent
ssh-add ~/.ssh/server.digitalocean_key

cd
sudo apt -y update && sudo apt -y upgrade

cd
wget https://majordomo-dotfiles.web.app/gitconfig && mv gitconfig .gitconfig
wget https://majordomo-dotfiles.web.app/gitignore && mv gitignore .gitignore
wget https://majordomo-dotfiles.web.app/gitignore_global && mv gitignore_global .gitignore_global


#############################################################################################################################################
# DEVELOPMENT

# INSTALL NVM & NODEJS
# cd
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# source ~/.zshrc 2>/dev/null
# nvm install --lts
# sudo ln -s "$(which node)" /usr/bin/node
# sudo ln -s "$(which npm)" /usr/bin/npm

# # INSTALL PNPM
# curl -fsSL https://get.pnpm.io/install.sh | sh -

#############################################################################################################################################
# CLEANUP & CREATE ENVIRONMENT
cd
rm *
mkdir git
cd git
git clone git@github.com:majordomo-systems/scraper.git
cd scraper
npm install
cd

# Create and display new SSH Key
ssh-keygen -t ed25519 -C "majordomo.systems"
cat ~/.ssh/id_ed25519.pub

# Start SSH Agent
eval `ssh-agent -s`

# Add new key to SSH Agent
ssh-add ~/.ssh/id_ed25519

# Create NGINX Proxy
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

# Create VSCode Server
mkdir -p ~/.config
docker run -d --expose 80 -e VIRTUAL_HOST=code.majordomo.systems -e VIRTUAL_PORT=8080 -e LETSENCRYPT_HOST=code.majordomo.systems -e LETSENCRYPT_EMAIL=admin@majordomo.systems --name code-server -e PASSWORD='developer' \
  -v "$HOME/.config:/home/coder/.config" \
  -u "$(id -u):$(id -g)" \
  codercom/code-server:latest

# Create n8n Server
docker volume create n8n_data
docker run -v /home/developer/git/scraper:/home/node/scraper -e VIRTUAL_HOST=n8n.majordomo.systems -it --rm --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n &

# Create WebSSH2 Connection
# docker run -e VIRTUAL_HOST=shell.majordomo.systems -it --rm --name webssh2 -p 2222:2222 psharkey/webssh2

#############################################################################################################################################
# Create startup file for code-server and configure to start automatically after a reboot
# Create a startup file for code-server & n8n
cd
echo '
# login to Docker
docker login --username majordomo-admin --password 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 ghcr.io
# use this command to run this script
# ./start-containers &
# stop and remove any previous instances of nginx-proxy
docker rm $(docker stop $(docker ps -a -q --filter ancestor=jwilder/nginx-proxy --format="{{.ID}}"))
docker rm $(docker stop $(docker ps -a -q --filter ancestor=jrcs/letsencrypt-nginx-proxy-companion --format="{{.ID}}"))
# stop and remove any previous instances of code-server
docker rm $(docker stop $(docker ps -a -q --filter ancestor=codercom/code-server:latest --format="{{.ID}}"))
# stop and remove any previous instances of n8n
docker rm $(docker stop $(docker ps -a -q --filter ancestor=docker.n8n.io/n8nio/n8n --format="{{.ID}}"))
# stop and remove any previous instances of webssh2
# docker rm $(docker stop $(docker ps -a -q --filter ancestor=psharkey/webssh2 --format="{{.ID}}"))
# start nginx-proxy
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
# start code-server
docker run -d --expose 80 -e VIRTUAL_HOST=code.majordomo.systems -e VIRTUAL_PORT=8080 -e LETSENCRYPT_HOST=code.majordomo.systems -e LETSENCRYPT_EMAIL=admin@majordomo.systems --name code-server -e PASSWORD='developer' \
  -v "$HOME/.config:/home/coder/.config" \
  -u "$(id -u):$(id -g)" \
  codercom/code-server:latest
# start n8n
docker run -v /home/developer/git/scraper:/home/node/scraper -e VIRTUAL_HOST=n8n.majordomo.systems -e LETSENCRYPT_HOST=n8n.majordomo.systems -e LETSENCRYPT_EMAIL=admin@majordomo.systems -it --rm --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n &
# start webssh2
# docker run -e VIRTUAL_HOST=shell.majordomo.systems -e LETSENCRYPT_HOST=shell.majordomo.systems -e LETSENCRYPT_EMAIL=admin@majordomo.systems -it --rm --name webssh2 -p 2222:2222 psharkey/webssh2
cd
# start majordomo.systems
cd ~/git
cd majordomo.systems
docker run -e VIRTUAL_HOST=majordomo.systems -e LETSENCRYPT_HOST=majordomo.systems -e LETSENCRYPT_EMAIL=admin@majordomo.systems -d --rm  -p 3000:3000 --name majordomo-systems majordomo-systems
# start majordomo.studio
cd ~/git
cd majordomo.studio
docker run -e VIRTUAL_HOST=majordomo.studio -e LETSENCRYPT_HOST=majordomo.studio -e LETSENCRYPT_EMAIL=admin@majordomo.systems -d --rm  -p 9890:3000 --name majordomo-studio majordomo-studio
# start ggg.studio
cd ~/git
cd ggg.studio
docker run -e VIRTUAL_HOST=ggg.studio -e LETSENCRYPT_HOST=ggg.studio -e LETSENCRYPT_EMAIL=admin@majordomo.systems -d --rm  -p 9891:3000 --name ggg-studio ggg-studio
' > ~/start-containers
sudo chmod +x start-containers

# Create a service and add it to init.d
cd
sudo echo '
[Unit]
Description=Start Containers
After=network.target

[Service]
ExecStart=/home/developer/start-containers &

[Install]
WantedBy=default.target
' > ~/containers.service
sudo mv containers.service /etc/systemd/system/
sudo chmod +x /etc/systemd/system/containers.service
sudo systemctl daemon-reload
sudo systemctl enable containers.service
sudo systemctl start containers.service
#############################################################################################################################################
exit
echo "Restarting in 10 seconds................................................."
sleep 1
echo "9........"
sleep 1
echo "8......."
sleep 1
echo "7......"
sleep 1
echo "6....."
sleep 1
echo "5...."
sleep 1
echo "4..."
sleep 1
echo "3.."
sleep 1
echo "2."
sleep 1
echo "1"
sleep 1
echo "Bye bye!"
shutdown -r now
#############################################################################################################################################

# n8n configuration