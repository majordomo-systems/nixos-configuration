{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tmate
    ntp
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
    gzip
    unzip
    neofetch
    timeshift
    trash-cli
    speedtest-cli
    protonvpn-cli
    openvpn
    open-vm-tools
  ];
}