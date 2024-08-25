# Ubuntu
sudo apt-get clean
sudo apt-get autoremove
sudo apt-get --purge autoremove
sudo apt-get remove --purge $(deborphan)
sudo journalctl --vacuum-time=2weeks
rm -rf ~/.cache/thumbnails/*

# Nix
sudo nix-collect-garbage --delete-older-than 1d
sudo nix-collect-garbage -d
sudo rm -rf /nix/var/nix/gcroots/auto/*
nix-env --delete-generations old
nix-store --optimise
# If you want to remove previous boot versions:
# sudo nixos-rebuild boot
