{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tmate
    git
    gh
    docker
    docker-compose
    lazydocker
    ctop
    htop
    btop
    mc
    tldr
    jq
    duf
    w3m
    zip
    unzip
    trash-cli
    neofetch
    openvpn
    open-vm-tools
    speedtest-cli
    python3
  ];
}