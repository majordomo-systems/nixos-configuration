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
    gnomeExtensions.dash-to-panel
    gnomeExtensions.dock-from-dash
    gnomeExtensions.quake-terminal
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.blur-my-shell
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.bluetooth-quick-connect
    gnomeExtensions.forge
    gnomeExtensions.logo-menu
    gnomeExtensions.vitals
    gnomeExtensions.space-bar
    gnomeExtensions.top-bar-organizer
    protonvpn-gui
    pavucontrol
    flameshot
    tilix
    alacritty
    firefox
    chromium
    ungoogled-chromium
    dunst
    networkmanagerapplet
    vscode

    # hyprland:
    # hyprland
    # waybar
    # swww # for wallpapers
    # xdg-desktop-portal-gtk
    # xdg-desktop-portal-hyprland
    # xwayland
    # meson
    # wayland-protocols
    # wayland-utils
    # wl-clipboard
    # wlroots
     
    # x86 systems only:
      # hyper
      # warp-terminal
      # zoom-us
  ];
}

