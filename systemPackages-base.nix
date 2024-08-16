{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gh
    lazygit
    docker
    docker-compose
    lazydocker
    coreutils
    gcc
    wget
    curl
    xclip
    openssh
    openssl
    ccrypt
    ripgrep
    fd
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
    vimPlugins.LazyVim
    vimPlugins.nvim-treesitter
  ];
}