{ lib, config, pkgs, ... }:

let
  # Fetch the Catppuccin Frappé theme
  catppuccinFrappe = pkgs.fetchurl {
    url = "https://github.com/catppuccin/alacritty/raw/main/catppuccin-frappe.toml";
    sha256 = "1rax13hqxy02n3wl92if6q18zxz63aq28fhdcc0zb038v4k52rhf";
  };

in
{
  # Ensure Alacritty and related packages are installed
  home.packages = [
    pkgs.alacritty
  ];

  # Copy the Catppuccin Frappé theme to the Alacritty config directory
  xdg.configFile."alacritty/catppuccin-frappe.toml".source = catppuccinFrappe;

  # Create or update the Alacritty configuration file
  xdg.configFile."alacritty/alacritty.toml".text = ''
    import = [ "~/.config/alacritty/catppuccin-frappe.toml" ]

    [font]
      normal = { family = "FiraMono Nerd Font" }
      size = 18.0

    [window]
      opacity = 0.67
      # fullscreen = true
      dimensions = { columns = 120, lines = 30 }

    [shell]
      program = "/run/current-system/sw/bin/tmux"
      args = [ "new-session", "-A", "-s", "main" ]
  '';
}
