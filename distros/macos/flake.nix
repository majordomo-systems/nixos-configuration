{
  description = "Example nix-darwin system flake with Home Manager";

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
        mkalias # Required for Mac/Darwin installations
        # open-vm-tools
        # coreutils
        # exfatprogs
        # hfsprogs
        # gparted
        # distrobox
        # protonvpn-cli

        # CORE SYSTEM
        zsh
        zsh-vi-mode
        nushell
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
      ];

      # Copy NvChad to ~/.config/nvim
      environment.etc."nvim".source = (pkgs.callPackage ./nvchad.nix {}).nvchad;

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
      programs.zsh.enable = true;

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
  