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

  home.username = "administrator";
  home.homeDirectory = "/home/administrator";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [];
}
