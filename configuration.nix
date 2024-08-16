{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./network.nix
      ./systemPackages-base.nix
      ./systemPackages-extended.nix
      # ./hosts/server.nix
      ./hosts/workstation.nix
      ./users.nix
      <catppuccin/modules/nixos>
      <home-manager/nixos>
    ];
  # ##################################################################################### #
  home-manager.backupFileExtension = "backup";
  
  home-manager.users.developer = {
    imports = [
      <catppuccin/modules/home-manager>
    ];
  };
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
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
  # Hyprland Configuration
  #  programs.hyprland = {
  #     enable = true; 
  #     # xwayland.hidpi = true;
  #     xwayland.enable = true;
  #   };
  # 
  #   # Hint Electon apps to use wayland
  #   environment.sessionVariables = {
  #     NIXOS_OZONE_WL = "1";
  #   };
  # 
  #   services.dbus.enable = true;
  #   xdg.portal = {
  #     enable = true;
  #     wlr.enable = true;
  #     extraPortals = [
  #       pkgs.xdg-desktop-portal-gtk
  #     ];
  #   };
  # 
  #   nixpkgs.overlays = [
  #     (self: super: {
  #       waybar = super.waybar.overrideAttrs (oldAttrs: {
  #         mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  #       });
  #     })
  #   ];
  # ##################################################################################### #

  programs.direnv.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}