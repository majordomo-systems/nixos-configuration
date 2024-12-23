{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.admin = {
    isNormalUser = true;
    description = "admin";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    home = "/home/admin";
    packages = with pkgs; [];
    # shell = pkgs.zsh;
  };

  # Enable automatic login for the user with updated option path
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "admin";

  # Workaround for GNOME autologin
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Configure Home Manager for developer
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.admin = import ./users/admin.home.nix;
  };

  # Create samba users for network drive access
  users.users.drive_readwrite = {
    isNormalUser = true;
    home = "/home/drive_readwrite";
    description = "User with read/write access to the shared drive";
  };

  users.users.drive_read = {
    isNormalUser = true;
    home = "/home/drive_read";
    description = "User with read-only access to the shared drive";
  };
}
