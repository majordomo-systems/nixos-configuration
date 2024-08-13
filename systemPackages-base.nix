{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    coreutils
    wget
    curl
    bash
    zsh
    oh-my-zsh
    zsh-powerlevel10k
    catppuccin
    protonvpn-cli
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