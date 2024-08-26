{ pkgs, config, ... }:
{
  programs.tmux = {
    enable = true;
    # shortcut = "a";
    # aggressiveResize = true; -- Disabled to be iTerm-friendly
    baseIndex = 1;
    newSession = true;
    # Stop tmux+escape craziness.
    escapeTime = 0;
    # Force tmux to use /tmp for sockets (WSL2 compat)
    secureSocket = false;

    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
      tmuxPlugins.yank
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.catppuccin
      # tmuxPlugins.dracula
    ];

    extraConfig = ''
      
      set -g prefix ^b                                        # Sets the prefix to Ctrl + b 
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"
      set-option -g mouse on                                  # Mouse works as expected
      set -g set-clipboard on                                 # Use system clipboard
      set -g @fzf-url-fzf-options '-p 60%,30% --prompt="   " --border-label=" Open URL "'
      set -g @fzf-url-history-limit '2000'
      # set -g status-position top                            # MacOS / darwin style

      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Start windows and panes at 1 not 0
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # Open panes in current directory
      bind '"'split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # set -g @catppuccin_window_left_separator ""
      # set -g @catppuccin_window_right_separator " "
      # set -g @catppuccin_window_middle_separator " █"
      # set -g @catppuccin_window_number_position "right"
      # set -g @catppuccin_window_default_fill "number"
      # set -g @catppuccin_window_default_text "#W"
      # set -g @catppuccin_window_current_fill "number"
      # set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
      # set -g @catppuccin_status_modules_right "directory meetings date_time"
      # set -g @catppuccin_status_modules_left "session"
      # set -g @catppuccin_status_left_separator  " "
      # set -g @catppuccin_status_right_separator " "
      # set -g @catppuccin_status_right_separator_inverse "no"
      # set -g @catppuccin_status_fill "icon"
      # set -g @catppuccin_status_connect_separator "no"
      # set -g @catppuccin_directory_text "#{b:pane_current_path}"
      # set -g @catppuccin_date_time_text "%H:%M"
    '';
  };

  programs.tmate = {
    enable = true;
    # FIXME: This causes tmate to hang.
    # extraConfig = config.xdg.configFile."tmux/tmux.conf".text;
  };

  home.packages = [
    # Open tmux for current project.
    (pkgs.writeShellApplication {
      name = "pux";
      runtimeInputs = [ pkgs.tmux ];
      text = ''
        PRJ="''$(zoxide query -i)"
        echo "Launching tmux for ''$PRJ"
        set -x
        cd "''$PRJ" && \
          exec tmux -S "''$PRJ".tmux attach
      '';
    })
  ];
}