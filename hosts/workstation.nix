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
    gnome-extension-manager
    gnomeExtensions.dash-to-panel
    gnomeExtensions.dock-from-dash
    gnomeExtensions.quake-terminal
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.blur-my-shell
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.bluetooth-quick-connect
    gnomeExtensions.forge
    gnomeExtensions.space-bar
    gnomeExtensions.top-bar-organizer
    github-desktop
    protonvpn-gui
    pavucontrol
    timeshift
    flameshot
    tilix
    alacritty
    firefox
    # chromium
    ungoogled-chromium
    dunst
    networkmanagerapplet
    vscode
     
    # x86 systems only:
      # hyper
      # warp-terminal
      # zoom-us
  ];
}

