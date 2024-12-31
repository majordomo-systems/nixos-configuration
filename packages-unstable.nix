{ config, pkgs, ... }:

let
  unstablePkgs = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in

{
  environment.systemPackages = with unstablePkgs; [
      ghostty
    ];
}
