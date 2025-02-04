#!/bin/bash

####################################################################################

# LOGIN TO DOCKER
# docker login --username majordomo-admin --password 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 ghcr.io
echo "" | docker login ghcr.io -u majordomo-admin --password-stdin

# USE THIS COMMAND TO RUN SCRIPT:
# ./start.sh &

####################################################################################

cd ~/Downloads/WebServer
docker compose up -d