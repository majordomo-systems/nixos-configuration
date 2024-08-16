{ lib, pkgs, ... }:

{
  programs.nnn = {
    enable = true;
    package = pkgs.nnn;
    extraPackages = with pkgs; [ mediainfo ffmpegthumbnailer ueberzug fzf bat ];

    plugins = {
      src = pkgs.fetchFromGitHub {
        owner = "jarun";
        repo = "nnn";
        rev = "v4.9";
        sha256 = "05ff2y6zbyqm3savq6ibq039jk8cz19jh445v72k9jw7gqinwpw3";
      } + "/plugins";

      mappings = {
        p = "preview-tui";
        c = "fzcd";
        f = "finder";
      };
    };
  };

  home.sessionVariables = {
    NNN_FIFO = "/tmp/nnn.fifo";
    NNN_PLUG = "/tmp/nnn/plugins";
  };

  # Create the FIFO automatically at login and copy plugins to tmp
  home.activation = {
    createFifo = lib.mkAfter ''
      if [ ! -p /tmp/nnn.fifo ]; then
        mkfifo /tmp/nnn.fifo
        chown developer:user /tmp/nnn.fifo
        chmod 600 /tmp/nnn.fifo
      fi

      # Copy plugins to a tmp directory
      if [ ! -d /tmp/nnn/plugins ]; then
        mkdir -p /tmp/nnn/plugins
        cp -r ${pkgs.fetchFromGitHub {
          owner = "jarun";
          repo = "nnn";
          rev = "v4.9";
          sha256 = "05ff2y6zbyqm3savq6ibq039jk8cz19jh445v72k9jw7gqinwpw3";
        } + "/plugins"}/* /tmp/nnn/plugins
        chmod -R 755 /tmp/nnn/plugins
      fi
    '';
  };
}
