{ config, pkgs, ... }:

{
  imports = [
    ../../../systemPackages-extended.nix
    ./applications/zsh.nix
  ];

  home.username = "developer";
  home.homeDirectory = "/home/developer";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    hd5
  ];
}