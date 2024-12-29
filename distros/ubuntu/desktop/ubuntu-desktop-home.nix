# nix run nixpkgs#home-manager -- switch
{ config, pkgs, ... }:

{
  imports = [
    # ./apps/bash.nix
    # ./apps/zsh.nix
    # ./apps/tmux.nix
    ./apps/tilix.nix
  ];

  # Enable the Catppuccin theme
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "developer";
  home.homeDirectory = "/home/developer";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # NvChad - Basically copy the whole nvchad that is fetched from github to ~/.config/nvim - if commented out, configuration is being managed by chezmoi
  # xdg.configFile."nvim/" = {
  #   source = (pkgs.callPackage ./apps/nvchad.nix{}).nvchad;
  # };

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # FONTS
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
    
    # OS Specific
    # mkalias # Required for Mac/Darwin installations
    # open-vm-tools
    coreutils
    exfatprogs
    hfsprogs
    gparted
    distrobox
    protonvpn-cli

    # CORE SYSTEM
    zsh
    zsh-vi-mode
    nushell
    gcc
    make
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
    # docker
    # docker-compose
    # lazydocker
    tldr
    xclip
    portal

    # EXTENDED SYSTEM
    neovim
    vimPlugins.nvchad
    vimPlugins.nvchad-ui
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
    glow

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
    networkmanagerapplet
    github-desktop
    tilix
    alacritty
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
    obsidian
     
    # x86 systems only:
    # hyper
    # vmware-workstation
    # zoom-us
  ];

  # fonts.fontconfig.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/developer/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Start the Docker Daemon
  virtualisation.docker.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}