#!/bin/bash

# wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/distros/macos/macos-install.sh

# NIX INSTALLATION


# NIX CONFIGURATION
cd ~/.config/nix/
wget https://raw.githubusercontent.com/majordomo-systems/nixos-configuration/main/distros/macos/flake.nix

# Sync chezmoi configuration
chezmoi update && chezmoi apply

# Setup Command Line LLM
cd ~/Library/Application*Support && mkdir io.datasette.llm && cd io.datasette.llm
ln -s ~/.config/io.datasette.llm/keys.json keys.json
