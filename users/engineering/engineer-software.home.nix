{ config, pkgs, ... }:

{
  imports = [
    ../../applications/zsh.nix
    ../../applications/bash.nix
    ../../applications/tmux.nix
    ../../applications/tilix.nix
  ];

  home.username = "developer";
  home.homeDirectory = "/home/developer";
  home.stateVersion = "24.05";

  # NvChad - Basically copy the whole nvchad that is fetched from github to ~/.config/nvim
  xdg.configFile."nvim/" = {
    source = (pkgs.callPackage ../../applications/nvchad.nix{}).nvchad;
  };

  # hyprland
  # xdg.configFile."hypr/hyprland.conf".text = ''
    # Your Hyprland configuration goes here
    # Remap the Super key to Caps Lock or another key
    # bind=MOD,Caps_Lock
  # '';

  # Alternatively, if you have the configuration in a separate file, you can link it like this:
  # xdg.configFile."hypr/hyprland.conf".source = ./path/to/your/hyprland.conf;

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
