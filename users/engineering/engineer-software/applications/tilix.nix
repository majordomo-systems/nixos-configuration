{ lib, config, pkgs, ... }:

let
  # Create a script to apply Tilix settings
  tilixSettingsScript = ''
    #!/usr/bin/env bash
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/use-system-font false
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/font "'FiraMono Nerd Font Mono 18'"
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/background-transparency-percent 33
  '';
in
{
  # Ensure Tilix and dconf are installed
  home.packages = [
    pkgs.tilix
    pkgs.dconf
  ];

  # Run the script during Home Manager activation
  home.activation.applyTilixSettings = lib.mkAfter ''
    ${pkgs.writeScript "apply-tilix-settings" ''
      ${pkgs.dconf}/bin/dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/use-system-font false
      ${pkgs.dconf}/bin/dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/font "'FiraMono Nerd Font Mono 18'"
      ${pkgs.dconf}/bin/dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/background-transparency-percent 33
    ''};
  '';
}
