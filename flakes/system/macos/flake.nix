# ---------------------------------------------------------------------------------
# To rebuild after making changes to flake:
#   darwin-rebuild switch --flake ~/.config/nix
# ---------------------------------------------------------------------------------

{
  description = "Nix-Darwin System Flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, config, ... }: {

      # Allow UnFree Packages
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile
      environment.systemPackages = with pkgs; [

        # OS Specific
        mkalias # For Mac/Darwin installations
        # coreutils
        # distrobox
        # open-vm-tools
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
        # gnome-tweaks
        # gnome-remote-desktop
        # gnome-extension-manager
        # gnomeExtensions.quick-settings-tweaker
        # gnomeExtensions.quick-settings-audio-panel
        # gnomeExtensions.privacy-settings-menu
        # gnomeExtensions.dash-to-panel
        # gnomeExtensions.quake-terminal
        # gnomeExtensions.alphabetical-app-grid
        # gnomeExtensions.clipboard-indicator
        # gnomeExtensions.auto-move-windows
        # gnomeExtensions.forge
        # gnomeExtensions.space-bar
        # gnomeExtensions.easy-docker-containers
        # gnomeExtensions.transparent-window-moving
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

      # Activation script to add nix GUI Apps to Spotlight
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';
            
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable direnv
      programs.direnv.enable = true;

      # Ensure Zsh is listed in /etc/shells
      # programs.zsh.enable = true;
      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
          # ZVM - A better and friendly vi(vim) mode plugin for ZSH.
          # https://github.com/jeffreytse/zsh-vi-mode
          interactiveShellInit = ''
            source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
          '';
        };
      };

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
        
      # Used for backwards compatibility, please read the changelog before changing.
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#MacBook-Pro-M3-Max
    darwinConfigurations."MacBook-Pro-M3-Max" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
      ];
    };
  };
}
  