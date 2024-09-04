# nix run nixpkgs#home-manager -- switch
{ config, pkgs, ... }:

{
  imports = [
    # ./apps/bash.nix
    # ./apps/zsh.nix
    ./apps/tmux.nix
    ./apps/tilix.nix
  ];

  # Enable the Catppuccin theme
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "admin";
  home.homeDirectory = "/home/admin";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # NvChad - Basically copy the whole nvchad that is fetched from github to ~/.config/nvim
  xdg.configFile."nvim/" = {
    source = (pkgs.callPackage ./apps/nvchad.nix{}).nvchad;
  };

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
    # docker
    # docker-compose
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
    # starship
    catppuccin
    imagemagick
    ffmpegthumbnailer
    poppler
    neovim
    vimPlugins.nvchad
    vimPlugins.nvchad-ui
    # vimPlugins.LazyVim
    # vimPlugins.catppuccin-nvim
    # vimPlugins.poimandres-nvim
    # vimPlugins.nnn-vim
    # vimPlugins.nvim-treesitter
    # open-vm-tools
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
    # gnome-tweaks
    # gnome-extension-manager
    # gnomeExtensions.dash-to-panel
    # gnomeExtensions.quake-terminal
    # gnomeExtensions.alphabetical-app-grid
    # gnomeExtensions.clipboard-indicator
    # gnomeExtensions.forge
    # gnomeExtensions.space-bar
    # gnomeExtensions.sound-output-device-chooser
    # gnomeExtensions.bluetooth-quick-connect
    # gnomeExtensions.top-bar-organizer
    # gnomeExtensions.blur-my-shell
    # gnomeExtensions.dock-from-dash
    # github-desktop
    # tilix
    # alacritty
    # brave
    # firefox
    # firefox-devedition
    # chromium
    # ungoogled-chromium
    # vscode
    # protonvpn-gui
    # pavucontrol
    # timeshift
    # flameshot
    # dunst
    # networkmanagerapplet
    # vmware-workstation
    firebase-tools
    nodenv
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    electron
    # python3
    go
    hugo

    # FONTS
    # corefonts
    nerdfonts
    fira
    fira-mono
    fira-code
    fira-code-nerdfont
    source-code-pro
    open-sans
    font-awesome
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}