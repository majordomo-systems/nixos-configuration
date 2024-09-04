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
    github-desktop
    tilix
    alacritty
    brave
    firefox
    firefox-devedition
    # chromium
    ungoogled-chromium
    vscode
    protonvpn-gui
    pavucontrol
    timeshift
    flameshot
    dunst
    networkmanagerapplet
     
    # x86 systems only:
      # hyper
      # warp-terminal
      # vmware-workstation
      # zoom-us
  ];
}

