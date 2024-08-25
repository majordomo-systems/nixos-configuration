sudo apt-get clean
sudo apt-get autoremove
sudo apt-get --purge autoremove
sudo apt-get remove --purge $(deborphan)
sudo journalctl --vacuum-time=2weeks
rm -rf ~/.cache/thumbnails/*

# Nix
nix-collect-garbage -d
sudo rm -rf /nix/var/nix/gcroots/auto/*
nix-env --delete-generations old
nix-store --optimise
