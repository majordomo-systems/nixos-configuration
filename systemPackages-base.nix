{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash
    zsh
    tmux
    fd
    bat
    fzf
    wget
    curl
    ripgrep
    git
    gh
    lazygit
    docker
    docker-compose
    lazydocker
    coreutils
    gcc
    xclip
    sshs
    openssh
    openssl
    portal
    ccrypt
    age
    yazi
    starship
    catppuccin
    imagemagick
    ffmpegthumbnailer
    poppler
    neovim
    vimPlugins.nvchad
    vimPlugins.nvchad-ui
    vimPlugins.LazyVim
    vimPlugins.catppuccin-nvim
    vimPlugins.poimandres-nvim
    vimPlugins.nnn-vim
    vimPlugins.nvim-treesitter
  ];
}