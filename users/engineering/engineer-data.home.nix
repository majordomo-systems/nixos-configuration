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
    hd5
  ];
}