{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tmate
    git
    gh
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
    neofetch
    trash-cli
    speedtest-cli
    protonvpn-cli
    openvpn
    open-vm-tools
    python3
  ];
}