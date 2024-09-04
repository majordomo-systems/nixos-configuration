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
adduser admin
usermod -a -G sudo admin
usermod -a -G docker admin
su admin
cd

# SSH CONFIGURATION
mkdir .ssh

# LOGOUT OF ADMIN
exit

# LOGOUT OF DROPLET
exit

####################################################################################

# COPY SSH KEY FROM LOCAL TO DROPLET
scp server.digitalocean_key root@68.183.194.146:/home/admin/.ssh/

# LOG BACK INTO DROPLET
ssh root@68.183.194.146
su admin
