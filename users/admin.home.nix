{ config, pkgs, ... }:

{
  imports = [
    # ../applications/bash.nix
    # ../applications/zsh.nix
    # ../applications/tmux.nix
    # ../applications/starship.nix
    # ../applications/nnn.nix
    ../applications/tilix.nix
  ];

  home.username = "admin";
  home.homeDirectory = "/home/admin";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [];
}
