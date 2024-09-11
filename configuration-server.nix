{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./network.nix
      ./users.nix
      ./system-packages.nix
      ./hosts/workstation.nix
      ./hosts/server.nix
      <catppuccin/modules/nixos>
      <home-manager/nixos>
    ];
  # ##################################################################################### #
  # Home Manager
  home-manager.backupFileExtension = "backup";
  
  home-manager.users.admin = {
    imports = [
      <catppuccin/modules/home-manager>
    ];
  };
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
  # ##################################################################################### #
  #  Enable xRDP for Remote Desktop Connections
  services.xrdp = {
    enable = true;
    port = 3389;
    openFirewall = true;
    defaultWindowManager = "${pkgs.gnome.gnome-session}/bin/gnome-session";
  };

  # Ensure Gnome doesn't sleep/suspend/hibernate
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # Mount exFAT drive (4tb network drive)
  fileSystems."/mnt/network_drive" = {
    device = "/dev/nvme0n1p1";  # or UUID
    fsType = "exfat";
    options = [ "uid=drive_readwrite" "gid=drive_group" "umask=0027" ];  # Adjust accordingly
  };

  services.samba = {
    enable = true;
    shares = {
      "network_drive" = {
        path = "/mnt/network_drive";
        writable = true;
        guestOk = false;
        validUsers = [ "drive_readwrite" "drive_read" ];  # Allow only the two users
        writeList = [ "drive_readwrite" ];  # Only drive_readwrite can write
      };
    };
  };

  virtualisation.docker.enable = true;

  # NixOS as a VM HOST - if you want to run VMs from within Nix(OS).
  # https://nixos.wiki/wiki/Virtualization
  virtualisation.vmware.host.enable = true;

  # NixOS as a VM GUEST - if you want to run this system from within a VM.
  # https://nixos.wiki/wiki/Virtualization
  # Enable vmware video driver for better performance:
  # services.xserver.videoDrivers = [ "vmware" ];
  # Enable VMWare guest tools:
  # virtualisation.vmware.guest.enable = true;


  # services.cockpit = {
  #   enable = true;
  #   package = pkgs.cockpit;
  # };

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
  programs.zsh.enable = true;
  # ##################################################################################### #
  # Enable CUPS to print documents.
  services.printing.enable = true;
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
  system.stateVersion = "24.05"; # Did you read the comment?
  # ##################################################################################### #

  # Enable automatic upgrades
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  # ##################################################################################### #

  # users.users.developer.shell = pkgs.zsh;
  # environment.shells = with pkgs; [ zsh ];

  # users.defaultUserShell=pkgs.zsh;

  programs.direnv.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}