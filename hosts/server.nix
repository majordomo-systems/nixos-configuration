{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    samba
  ];
}

