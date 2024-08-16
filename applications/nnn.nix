{ pkgs, ... }:

{
  programs.nnn = {
    enable = true;
    package = pkgs.nnn;
    extraPackages = with pkgs; [ mediainfo ffmpegthumbnailer ueberzug ];

    plugins = {
      src = pkgs.fetchFromGitHub {
        owner = "jarun";
        repo = "nnn";
        rev = "v4.9";
        sha256 = "05ff2y6zbyqm3savq6ibq039jk8cz19jh445v72k9jw7gqinwpw3";
      } + "/plugins";

      mappings = {
        p = "preview-tui";
      };
    };
  };

  home.sessionVariables = {
    NNN_FIFO = "/tmp/nnn.fifo";
    NNN_PLUG = "${pkgs.nnn}/share/nnn/plugins";
  };

  # Create the FIFO automatically at login:
  home.activation = {
    createFifo = ''
      if [ ! -p /tmp/nnn.fifo ]; then
        mkfifo /tmp/nnn.fifo
        chown developer:user /tmp/nnn.fifo
        chmod 600 /tmp/nnn.fifo
      fi
    '';
  };
}
