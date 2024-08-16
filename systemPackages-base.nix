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
    openssh
    openssl
    ccrypt
    ripgrep
    fzf
    nnn
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