{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tmate
    ntp
    ctop
    htop
    btop
    bottom
    tldr
    jq
    duf
    w3m
    zip
    gzip
    unzip
    zoxide
    neofetch
    timeshift
    trash-cli
    speedtest-cli
    protonvpn-cli
    openvpn
    open-vm-tools
  ];
}