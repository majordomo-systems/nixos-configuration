{ config, pkgs, ... }:

{
  imports = [
    ./applications/zsh.nix
  ];

  home.username = "developer";
  home.homeDirectory = "/home/developer";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    dnsutils
    whois
    nethogs
  ];
}