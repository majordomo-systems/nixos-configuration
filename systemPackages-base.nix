{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    coreutils
    wget
    curl
    bash
    zsh
    oh-my-zsh
    neovim
    vimPlugins.nvchad
    vimPlugins.nvchad-ui
    xclip
    openssl
    ccrypt
    ripgrep
    fzf
    tmux
  ];
}