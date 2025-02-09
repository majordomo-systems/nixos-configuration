#!/bin/bash

####################################################################################

# LOGIN TO DOCKER
# docker login --username majordomo-admin --password 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 ghcr.io
echo "" | docker login ghcr.io -u majordomo-admin --password-stdin

# USE THIS COMMAND TO RUN SCRIPT:
# ./start.sh &

####################################################################################

# stop and remove any previous instances of nginx-proxy
docker rm $(docker stop $(docker ps -a -q --filter ancestor=jwilder/nginx-proxy --format="{{.ID}}"))
docker rm $(docker stop $(docker ps -a -q --filter ancestor=jrcs/letsencrypt-nginx-proxy-companion --format="{{.ID}}"))

# stop and remove any previous instances of code-server
docker rm $(docker stop $(docker ps -a -q --filter ancestor=codercom/code-server:latest --format="{{.ID}}"))

# stop and remove any previous instances of n8n
docker rm $(docker stop $(docker ps -a -q --filter ancestor=docker.n8n.io/n8nio/n8n --format="{{.ID}}"))

# stop and remove any previous instances of webssh2
# docker rm $(docker stop $(docker ps -a -q --filter ancestor=psharkey/webssh2 --format="{{.ID}}"))

####################################################################################

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
# docker run -d --expose 80 -e VIRTUAL_HOST=code.majordomo.systems -e VIRTUAL_PORT=8080 -e LETSENCRYPT_HOST=code.majordomo.systems -e LETSENCRYPT_EMAIL=admin@majordomo.systems --name code-server -e PASSWORD='developer' \
#   -v "$HOME/.config:/home/coder/.config" \
#   -u "$(id -u):$(id -g)" \
#   codercom/code-server:latest

# start n8n
docker run -v /home/administrator/git/scraper:/home/node/scraper -e VIRTUAL_HOST=n8n.majordomo.systems -e LETSENCRYPT_HOST=n8n.majordomo.systems -e LETSENCRYPT_EMAIL=admin@majordomo.systems -it --rm --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n &

# start webssh2
# docker run -e VIRTUAL_HOST=shell.majordomo.systems -e LETSENCRYPT_HOST=shell.majordomo.systems -e LETSENCRYPT_EMAIL=admin@majordomo.systems -it --rm --name webssh2 -p 2222:2222 psharkey/webssh2

# start majordomo.systems
# cd ~/git
# cd majordomo.systems
docker run -e VIRTUAL_HOST=majordomo.systems -e LETSENCRYPT_HOST=majordomo.systems -e LETSENCRYPT_EMAIL=admin@majordomo.systems -d --rm  -p 3000:3000 --name majordomo-systems majordomo-systems

# start majordomo.studio
# cd ~/git
# cd majordomo.studio
# docker run -e VIRTUAL_HOST=majordomo.studio -e LETSENCRYPT_HOST=majordomo.studio -e LETSENCRYPT_EMAIL=admin@majordomo.systems -d --rm  -p 9890:3000 --name majordomo-studio majordomo-studio

# start ggg.studio
# cd ~/git
# cd ggg.studio
docker run -e VIRTUAL_HOST=v1.ggg.studio -e LETSENCRYPT_HOST=v1.ggg.studio -e LETSENCRYPT_EMAIL=admin@majordomo.systems -d --restart always -p 9891:3000 --name v1-ggg-studio ggg-studio

docker run -e VIRTUAL_HOST=ggg.studio -e LETSENCRYPT_HOST=ggg.studio -e LETSENCRYPT_EMAIL=admin@majordomo.systems -d --restart always -p 9892:3000 --name ggg-studio ghcr.io/majordomo-systems/ggg-studio:latest

# docker run -e VIRTUAL_HOST=dev.ggg.studio -e LETSENCRYPT_HOST=dev.ggg.studio -e LETSENCRYPT_EMAIL=admin@majordomo.systems -d --restart always -p 9893:3000 --name dev-ggg-studio ghcr.io/majordomo-systems/ggg-studio:latest

# start homepage dashboard
# docker run --name homepage \
# -e PUID=1000 \
# -e PGID=1000 \
# -e VIRTUAL_HOST=admin.majordomo.systems \
# -e LETSENCRYPT_HOST=admin.majordomo.systems \
# -e LETSENCRYPT_EMAIL=admin@majordomo.systems \
# -p 3001:3000 \
# -v /home/developer/homepage/config:/app/config \
# -v /var/run/docker.sock:/var/run/docker.sock:ro \
# --restart unless-stopped \
# ghcr.io/gethomepage/homepage:latest
