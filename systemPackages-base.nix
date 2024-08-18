{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash
    zsh
    oh-my-zsh
    zsh-powerlevel10k
    catppuccin
    tmux
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
    age
    ripgrep
    fd
    fzf
    nnn
    yazi
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