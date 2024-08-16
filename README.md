## NIXOS Configuration

### Install Home Manager

1. Add the channel first:

```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
sudo nix-channel --update
```

https://extensions.gnome.org/extension/6307/quake-terminal/
https://extensions.gnome.org/extension/1160/dash-to-panel/
https://extensions.gnome.org/extension/4269/alphabetical-app-grid/
https://extensions.gnome.org/extension/3193/blur-my-shell/
# https://extensions.gnome.org/extension/779/clipboard-indicator/
# https://extensions.gnome.org/extension/5237/rounded-window-corners/
# https://extensions.gnome.org/extension/906/sound-output-device-chooser/
# https://extensions.gnome.org/extension/905/refresh-wifi-connections/
# https://extensions.gnome.org/extension/1401/bluetooth-quick-connect/
# https://extensions.gnome.org/extension/19/user-themes/


sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --add https://github.com/catppuccin/nix/archive/main.tar.gz catppuccin
sudo nix-channel --update

[Installing NixOS with Hyprland!](https://josiahalenbrown.substack.com/p/installing-nixos-with-hyprland)

[Managing your NixOS configuration with Flakes and Home Manager!](https://josiahalenbrown.substack.com/p/managing-your-nixos-configuration)