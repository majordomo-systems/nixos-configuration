{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    
    open-vm-tools
    
    # CORE SYSTEM
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
    sshs
    openssh
    openssl
    portal
    tldr
    xclip

    # BASE SYSTEM
    exfatprogs
    hfsprogs
    gparted
    gcc
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

    # EXTENDED SYSTEM
    chezmoi
    tmate
    ntp
    ctop
    htop
    btop
    gdu
    bottom
    jq
    duf
    w3m
    zip
    gzip
    unzip
    zoxide
    neofetch
    distrobox
    trash-cli
    speedtest-cli
    protonvpn-cli
    openvpn
  ];
}