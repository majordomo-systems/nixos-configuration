{ config, pkgs, ... }:
{
  imports = [
    ../../applications/zsh.nix
    ../../applications/tmux.nix
    ../../applications/tilix.nix
  ];

  home.username = "developer";
  home.homeDirectory = "/home/developer";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    firebase-tools
    nodenv
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    electron
    python3
    go
  ];
}
