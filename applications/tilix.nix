{ lib, config, pkgs, ... }:

let
  # Fetch the Catppuccin theme zip using builtins.fetchurl
  catppuccinZip = builtins.fetchurl {
    url = "https://github.com/catppuccin/tilix/archive/refs/heads/main.zip";
    sha256 = "12kfswrxk0wcjrf39vyzzm0wjdw4zpf7s94l7al6b8ynm8y9s1vs";
  };

  # Create a script to apply Tilix settings #212431
  tilixSettingsScript = ''
    #!/usr/bin/env bash
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/use-system-font false
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/font "'FiraMono Nerd Font 18'"
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/background-transparency-percent 33
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/color-scheme "'Catppuccin Frappé'"
  '';

  # Define the directory for Tilix themes
  tilixThemeDir = "${config.home.homeDirectory}/.config/tilix/schemes";

  # Script to extract Catppuccin themes
  tilixThemeSetupScript = pkgs.writeScript "setup-tilix-catppuccin-theme" ''
    #!/usr/bin/env bash
    set -e

    mkdir -p ${tilixThemeDir}
    tmp_dir=$(mktemp -d)
    trap "rm -rf $tmp_dir" EXIT

    ${pkgs.unzip}/bin/unzip ${catppuccinZip} -d $tmp_dir
    cp $tmp_dir/tilix-main/themes/* ${tilixThemeDir}

    echo "Catppuccin themes have been installed."
  '';
in
{
  # Ensure Tilix, dconf, and unzip are installed
  home.packages = [
    pkgs.tilix
    pkgs.dconf
    pkgs.unzip
  ];

  # Run the theme setup script during Home Manager activation
  home.activation.setupTilixCatppuccinTheme = lib.mkAfter ''
    ${tilixThemeSetupScript}
  '';

  # Run the script to apply Tilix settings during Home Manager activation
  home.activation.applyTilixSettings = lib.mkAfter ''
    ${pkgs.writeScript "apply-tilix-settings" ''
      ${pkgs.dconf}/bin/dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/use-system-font false
      ${pkgs.dconf}/bin/dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/font "'FiraMono Nerd Font 18'"
      ${pkgs.dconf}/bin/dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/background-transparency-percent 33
      ${pkgs.dconf}/bin/dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/color-scheme "'Catppuccin Frappé'"
    ''};
  '';
}
