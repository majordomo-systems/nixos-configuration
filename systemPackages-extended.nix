{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chezmoi
    tmate
    ntp
    ctop
    htop
    btop
    gdu
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
    trash-cli
    speedtest-cli
    protonvpn-cli
    openvpn
    open-vm-tools
  ];
}