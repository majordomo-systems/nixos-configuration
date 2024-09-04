{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    samba
    cockpit
    kasmweb
  ];
}

