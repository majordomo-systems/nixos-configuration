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
      #corefonts # Microsoft free fonts
      inconsolata # monospaced
      unifont # some international languages
      font-awesome
      freefont_ttf
      open-sans
      liberation_ttf
      liberation-sans-narrow
      ttf_bitstream_vera
      libertine
      ubuntu_font_family
      gentium
      # Good monospace fonts
      source-code-pro
    ];
  };

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    pavucontrol
    flameshot
    tilix
    firefox
    chromium
    vscode
    # zoom-us # x86 systems only
  ];
}

