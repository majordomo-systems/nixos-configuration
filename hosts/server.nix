{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vmware-workstation
    samba
    kasmweb
  ];
}
