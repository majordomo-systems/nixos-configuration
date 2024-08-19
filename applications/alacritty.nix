{ lib, config, pkgs, ... }:

let
  # Fetch the Catppuccin Frappé theme
  # catppuccinFrappe = pkgs.fetchurl {
  #   url = "https://github.com/catppuccin/alacritty/raw/main/catppuccin-frappe.toml";
  #   sha256 = "1rax13hqxy02n3wl92if6q18zxz63aq28fhdcc0zb038v4k52rhf";
  # };

  # Fetch the Catppuccin Mocha theme
  catppuccinMocha = pkgs.fetchurl {
    url = "https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml";
    sha256 = "1rnc6gsqjdvkb6xbv1pnawrp6f0j5770dqml2di90j3lhv0fppgw";
  };

in
{
  # Ensure Alacritty and related packages are installed
  home.packages = [
    pkgs.alacritty
  ];

  # Copy the Catppuccin Frappé theme to the Alacritty config directory
  # xdg.configFile."alacritty/catppuccin-frappe.toml".source = catppuccinFrappe;
  xdg.configFile."alacritty/catppuccin-mocha.toml".source = catppuccinMocha;

  # Create or update the Alacritty configuration file
  xdg.configFile."alacritty/alacritty.toml".text = ''
    # import = [ "~/.config/alacritty/catppuccin-frappe.toml" ]
    import = [ "~/.config/alacritty/catppuccin-mocha.toml" ]

    [font]
      normal = { family = "FiraMono Nerd Font" }
      size = 18.0

    [window]
      opacity = 0.67
      # fullscreen = true
      dimensions = { columns = 120, lines = 30 }

    # Launch TMUX Automatically
    # [shell]
    #   program = "/run/current-system/sw/bin/tmux"
    #   args = [ "new-session", "-A", "-s", "main" ]
  '';
}
