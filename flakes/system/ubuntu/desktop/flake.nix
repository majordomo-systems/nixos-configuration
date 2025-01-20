# ---------------------------------------------------------------------------------
# Shell commands to build/activate the configuration:
#   nix flake update
#   nix build .#homeConfigurations.developer.activationPackage
#   nix run .#homeConfigurations.developer.activationPackage
# ---------------------------------------------------------------------------------

{
  description = "Home Manager Configuration for Ubuntu Desktop";

  inputs = {
    # Specify the source of Home Manager, Nixpkgs, and Catppuccin.
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { nixpkgs, home-manager, catppuccin, ... }:
    let
      # Adjust to match platform, for instance x86_64-linux or aarch64-linux.
      system = "aarch64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."developer" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          {
            # External module imports (like ./apps/tilix.nix),
            imports = [
              # ./apps/bash.nix
              # ./apps/zsh.nix
              # ./apps/tmux.nix
              # ./apps/tilix.nix
            ];
            # ##################################################################################### #
            # Enable the Catppuccin theme
            catppuccin = {
              enable = true;
              flavor = "mocha";
            };
            # ##################################################################################### #
            # Home Manager needs a bit of information about you and the paths it should manage.
            home.username = "developer";
            home.homeDirectory = "/home/developer";
            # ##################################################################################### #
            # This value determines the Home Manager release that your configuration is
            # compatible with. This helps avoid breakage when a new Home Manager release
            # introduces backwards incompatible changes.
            #
            # You should not change this value, even if you update Home Manager. If you do
            # want to update the value, then make sure to first check the Home Manager
            # release notes.
            home.stateVersion = "24.11"; # Read the comment before changing.
            # ##################################################################################### #
            # Allow UnFree Packages
            nixpkgs.config.allowUnfree = true;
            # ##################################################################################### #
            # The home.packages option allows you to install Nix packages into your environment.
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
              # nerdfonts
              fira
              fira-mono
              fira-code
              fira-code-nerdfont
              source-code-pro
              open-sans
              font-awesome

              # OS Specific
              # mkalias # For Mac/Darwin installations
              coreutils
              distrobox
              open-vm-tools
              # protonvpn-cli

              # CORE SYSTEM
              zsh
              zsh-vi-mode
              nushell
              neovim
              chezmoi
              gcc
              gnumake
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
              zoxide
              git
              gh
              lazygit
              lazydocker
              tldr
              xclip
              portal
              starship
              catppuccin
              imagemagick
              ffmpegthumbnailer
              poppler
              tmate
              yazi
              navi
              gdu
              bottom
              tldr
              jq
              duf
              w3m
              zip
              gzip
              unzip
              neofetch
              trash-cli
              speedtest-cli
              tailscale
              ntp
              ctop
              htop
              btop
              glow

              # EXTENDED SYSTEM
              llm
              # openvpn
              # docker
              # docker-compose
              # kubernetes

              # LINUX WORKSTATION
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
              # networkmanagerapplet
              # github-desktop
              # tilix
              # alacritty
              # warp-terminal
              # brave
              # firefox
              # firefox-devedition
              # chromium
              # ungoogled-chromium
              # vscode
              # (import <nixos-unstable> {}).vscode
              # protonvpn-gui
              # pavucontrol
              # timeshift
              # flameshot
              # dunst
              # obsidian

              # BARE METAL SERVER
              # exfatprogs
              # hfsprogs
              # gparted
              # samba
              # kasmweb
              # vmware-workstation
              
              # x86 SYSTEMS ONLY:
              # code-cursor
              # hyper
              # vmware-workstation
              # zoom-us
            ];
            # ##################################################################################### #
            # fonts.fontconfig.enable = true;
            # ##################################################################################### #
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
            # ##################################################################################### #
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
            # ##################################################################################### #
            # Start the Docker Daemon
            # virtualisation.docker.enable = true;
            # ##################################################################################### #
            # Let Home Manager install and manage itself.
            programs.home-manager.enable = true;
          }
          # ##################################################################################### #
          # Include Catppuccin's Home Manager module as you originally did:
          catppuccin.homeManagerModules.catppuccin
          # ##################################################################################### #
        ];
      };
    };
}
