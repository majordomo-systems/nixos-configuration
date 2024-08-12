{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.developer = {
    isNormalUser = true;
    description = "developer";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    home = "/home/developer";
    packages = with pkgs; [];
  };

  # Enable automatic login for the user with updated option path
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "developer";

  # Workaround for GNOME autologin
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Configure Home Manager for developer
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.developer = import ./users/engineering/engineer-software/engineer-software.home.nix;
  };
}
