# Setup Additional Drives

## Network Drive User Setup

***Assumes the following group and users exist:***

group = drivegroup
sudo groupadd drive_group

drive_read - guest
drive_readwrite - bona*****

***Add to users.nix:***
users.users.drive_readwrite = {
  isNormalUser = true;
  home = "/home/drive_readwrite";
  description = "User with read/write access to the shared drive";
};

users.users.drive_read = {
  isNormalUser = true;
  home = "/home/drive_read";
  description = "User with read-only access to the shared drive";
};

## Network Drive Setup

1) Format drive (GPT partition table // btrfs)
2) ***Create a Mount Point:*** sudo mkdir -p /mnt/network_drive
3) ***Edit /etc/nixos/configuration.nix:***
fileSystems."/mnt/network_drive" = {
  device = "/dev/nvme0n1p1";  # Replace with the correct partition or UUID
  fsType = "btrfs";
  options = [ "defaults" ];  # You can customize options if needed
};
4) sudo nixos-rebuild switch
5) ***Set the Ownership of the Mount Point: Change the owner of /mnt/network_drive to drive_readwrite and the group to drive_group:***
sudo chown -R drive_readwrite:drive_group /mnt/network_drive
6) ***Set the Permissions: Set the directory permissions so that:***
- The owner (drive_readwrite) has full read/write/execute access.
- The group (drive_group), which includes drive_read, has read/execute access.
sudo chmod -R 775 /mnt/network_drive
7) ***Add Samba Configuration to /etc/nixos/configuration.nix:***
- Only drive_readwrite and drive_read can access the shared folder.
- Only drive_readwrite can write to the shared folder, while drive_read has read-only access.
services.samba = {
  enable = true;
  shares = {
    "network_drive" = {
      path = "/mnt/network_drive";
      writable = true;
      guestOk = false;  # No guest access
      validUsers = [ "drive_readwrite" "drive_read" ];  # Only these users can access
      writeList = [ "drive_readwrite" ];  # Only drive_readwrite can write
    };
  };
};
8) ***Set Samba Passwords: Set up Samba passwords for both drive_readwrite and drive_read:***
sudo smbpasswd -a drive_readwrite
sudo smbpasswd -a drive_read
9) ***Rebuild:*** sudo nixos-rebuild switch
10) ***Test the Share:***
smb://<your-nixos-ip-address>/network_drive
