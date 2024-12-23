{ config, pkgs, ... }:

{
  # Fonts
  fonts = {
    fontDir = {
      enable = true;
    };
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      #corefonts # Microsoft fonts
      ubuntu_font_family
      nerdfonts
      fira
      fira-mono
      fira-code
      fira-code-nerdfont
      source-code-pro
      open-sans
      font-awesome
    ];
  };
  
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
    vimPlugins.nvchad
    vimPlugins.nvchad-ui
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

    # SERVER
    # vmware-workstation
    # samba
    # kasmweb

    # WORKSTATION
    gnome-tweaks
    gnome-remote-desktop
    gnome-extension-manager
    gnomeExtensions.quick-settings-tweaker
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.privacy-settings-menu
    gnomeExtensions.dash-to-panel
    gnomeExtensions.quake-terminal
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.auto-move-windows
    gnomeExtensions.forge
    gnomeExtensions.space-bar
    gnomeExtensions.easy-docker-containers
    gnomeExtensions.transparent-window-moving
    # gnomeExtensions.gsconnect
    # gnomeExtensions.pano
    # gnomeExtensions.blur-my-shell
    # gnomeExtensions.astra-monitor
    # gnomeExtensions.dock-from-dash
    # gnomeExtensions.sound-output-device-chooser
    # gnomeExtensions.bluetooth-quick-connect
    # gnomeExtensions.easyScreenCast
    # gnomeExtensions.tiling-assistant
    # gnomeExtensions.logo-menu
    # gnomeExtensions.top-bar-organizer
    # gnomeExtensions.transparent-top-bar-adjustable-transparency
    github-desktop
    tilix
    warp-terminal
    brave
    firefox
    firefox-devedition
    # chromium
    ungoogled-chromium
    vscode
    # (import <nixos-unstable> {}).vscode
    protonvpn-gui
    pavucontrol
    timeshift
    flameshot
    dunst
    networkmanagerapplet
     
    # x86 systems only:
    # hyper
    # vmware-workstation
    # zoom-us
  ];
}