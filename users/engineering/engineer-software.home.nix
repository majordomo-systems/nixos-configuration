{ config, pkgs, ... }:

{
  imports = [
    ../../applications/zsh.nix
    ../../applications/bash.nix
    ../../applications/tmux.nix
    ../../applications/tilix.nix
    ../../applications/nnn.nix
    ../../applications/alacritty.nix
  ];

  home.username = "developer";
  home.homeDirectory = "/home/developer";
  home.stateVersion = "24.05";

  # NvChad - Basically copy the whole nvchad that is fetched from github to ~/.config/nvim
  xdg.configFile."nvim/" = {
    source = (pkgs.callPackage ../../applications/nvchad.nix{}).nvchad;
  };

  home.packages = with pkgs; [
    firebase-tools
    nodenv
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    electron
    python3
    go
    hugo
  ];
}
