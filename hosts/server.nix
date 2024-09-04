{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    warp-terminal
    vmware-workstation

    samba
    cockpit
    kasmweb
  ];
}
