{ config, pkgs, ... }:

{
  imports = [
    ../applications/zsh.nix
    ../applications/bash.nix
    ../applications/tmux.nix
    ../applications/tilix.nix
    ../applications/starship.nix
    # ../applications/nnn.nix
  ];

  home.username = "developer";
  home.homeDirectory = "/home/developer";
  home.stateVersion = "24.05";

  # NvChad - Basically copy the whole nvchad that is fetched from github to ~/.config/nvim
  xdg.configFile."nvim/" = {
    source = (pkgs.callPackage ../applications/nvchad.nix{}).nvchad;
  };

  home.packages = with pkgs; [];
}
