{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./network.nix
      ./users.nix
      ./packages.nix
      ./packages-unstable.nix
      <catppuccin/modules/nixos>
      <home-manager/nixos>
    ];
  # ##################################################################################### #
  # Home Manager
  home-manager.backupFileExtension = "backup";
  
  home-manager.users.developer = {
    imports = [
      <catppuccin/modules/home-manager>
    ];
  };
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  # ##################################################################################### #
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # ##################################################################################### #
  # Set your time zone.
  time.timeZone = "America/Toronto";
  # ##################################################################################### #
  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";
  # ##################################################################################### #
  # Ensure Zsh is listed in /etc/shells
  # programs.zsh.enable = true;
  # programs.zsh.enableCompletion = true;  
  # programs.zsh.autosuggestions.enable = true;
  # programs.zsh.syntaxHighlighting.enable = true;
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting = {
        enable = true;
        styles = {
          comment = "fg=yellow";
          precommand = "fg=magenta,underline";
          command = "fg=blue,bold";
          alias = "fg=blue,bold";
          builtin = "fg=cyan";
          reserved-word = "fg=magenta,bold";
          unknown-token = "fg=red,bold";
        };
      };
      # ZVM - A better and friendly vi(vim) mode plugin for ZSH.
      # https://github.com/jeffreytse/zsh-vi-mode
      interactiveShellInit = ''
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      '';
    };
  };
  # ##################################################################################### #
  # Set default shell to zsh for all users
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell=pkgs.zsh;
  # ##################################################################################### #
  # Set default shell to zsh for specific user only
  # users.users.developer.shell = pkgs.zsh;
  # ##################################################################################### #
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # ##################################################################################### #
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  # ##################################################################################### #
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # ##################################################################################### #
  # Allow UnFree Packages
  nixpkgs.config.allowUnfree = true;
  # ##################################################################################### #
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # ##################################################################################### #
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
  # ##################################################################################### #
  # Enable automatic upgrades
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  # ##################################################################################### #
  # Enable direnv
  programs.direnv.enable = true;
  # ##################################################################################### #
  # Enable flakes and experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # ##################################################################################### #
  # Enable the X11 windowing system and GNOME.
  services.xserver = {
    enable = true;

    # Updated layout and variant options
    xkb = {
      layout = "us";
      variant = "";
    };

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  # ##################################################################################### #
}
