{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    lazydocker
    coreutils
    wget
    curl
    xclip
    openssl
    ccrypt
    ripgrep
    fzf
    tmux
    bash
    zsh
    oh-my-zsh
    zsh-powerlevel10k
    catppuccin
    neovim
    vimPlugins.nvchad
    vimPlugins.nvchad-ui
  ];
}