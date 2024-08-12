{ config, pkgs, ... }:
{
  imports = [
    ./applications/zsh.nix
    ./applications/tmux.nix
  ];

  home.username = "developer";
  home.homeDirectory = "/home/developer";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    zsh-powerlevel10k
    catppuccin
    firebase-tools
  ];
}
