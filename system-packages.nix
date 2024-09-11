{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    
    # BASE SYSTEM
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
    exfatprogs
    hfsprogs
    gparted
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

    # EXTENDED SYSTEM
    chezmoi
    tmate
    ntp
    ctop
    htop
    btop
    gdu
    bottom
    tldr
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
    open-vm-tools
  ];
}