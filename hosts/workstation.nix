{ config, pkgs, ... }:

{
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Fonts
  fonts = {
    fontDir = {
      enable = true;
    };
    enableGhostscriptFonts = true;
    packages = with pkgs; [
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
    ];
  };

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.quake-terminal
    gnomeExtensions.alphabetical-app-grid
    protonvpn-gui
    pavucontrol
    flameshot
    tilix
    firefox
    chromium
    vscode
    # hyper # x86 systems only
    # warp-terminal
    # zoom-us
  ];
}

