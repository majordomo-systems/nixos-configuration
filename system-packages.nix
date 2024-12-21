{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    
    open-vm-tools
    coreutils
    exfatprogs
    hfsprogs
    gparted
    distrobox
    protonvpn-cli
    # mkalias

    # CORE SYSTEM
    bash   
    zsh
    gcc
    sshs
    openssh
    openssl
    direnv 
    ccrypt
    age   
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
    tldr
    xclip
    portal

    # EXTENDED SYSTEM
    neovim
    # vimPlugins.nvchad
    # vimPlugins.nvchad-ui
    # vimPlugins.LazyVim
    # vimPlugins.catppuccin-nvim
    # vimPlugins.poimandres-nvim
    # vimPlugins.nnn-vim
    # vimPlugins.nvim-treesitter
    # vimPlugins.avante-nvim  
    chezmoi
    starship
    catppuccin
    imagemagick
    ffmpegthumbnailer
    poppler
    yazi
    tmate
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
    trash-cli
    speedtest-cli
    openvpn
    ntp
    ctop
    htop 
    btop
  ];
}