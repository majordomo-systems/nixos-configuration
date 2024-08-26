{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''

      # set a fancy prompt (non-color, unless we know we "want" color)
      case "$TERM" in
          xterm-color|*-256color) color_prompt=yes;;
      esac

      # enable color support of ls and also add handy aliases
      if [ -x /usr/bin/dircolors ]; then
          test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
          alias grep='grep --color=auto'
          alias fgrep='fgrep --color=auto'
          alias egrep='egrep --color=auto'
      fi

      # --- setup fzf ---
      # fzf key bindings and fuzzy completion
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh

      # --- setup fzf theme --- https://github.com/catppuccin/fzf
      export FZF_DEFAULT_OPTS=" \
      --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
      --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
      --color=selected-bg:#45475a \
      --multi \
      --height 40% \
      --layout=reverse"

      # Starship initialization
      eval "$(starship init zsh)"
      
      # Zoxide initialization
      eval "$(zoxide init zsh)"

      # Bindings
      bindkey "\e[A" history-search-backward
      bindkey "\e[B" history-search-forward
      bindkey "\e[C" forward-char
      bindkey "\e[D" backward-char
      bindkey '^f' autosuggest-accept

      # Alias
      alias ..="cd .."
      alias ...="cd ../.."
      alias ....="cd ../../.."
      alias c="clear"
      alias e="exit"
      alias tn="(){ tmux new -s \$1 }"
      alias p="pnpm"
      alias l="ls -laF"                     # List in long format, include dotfiles
      alias ls="ls -laF --color=auto"       # List in long format, include dotfiles
      alias ld="ls -ld */"                  # List in long format, only directories
      alias nv="nvim"
      alias t="tmux"
      alias nnn='nnn -de'
      alias pico='nano'
      alias lzd='lazydocker'
      alias fzf='fzf --preview="bat --color=always {}"'
      # Open multiple files in VSCode/NeoVim [Tab to select, ENTER to open in VSCode]
      alias cfzf='code $(fzf -m --preview="bat --color=always {}")'
      alias nfzf='nvim $(fzf -m --preview="bat --color=always {}")'

      # Cleanup
      if [ "$(grep '^NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '"')" = "NixOS" ]; then
        alias cleanup='sudo nix-collect-garbage --delete-older-than 1d && sudo nix-collect-garbage -d && sudo rm -rf /nix/var/nix/gcroots/auto/* && nix-env --delete-generations old && nix-store --optimise && sudo nixos-rebuild boot'
      elif [ "$(grep '^NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '"')" = "Ubuntu" ]; then
        alias cleanup='sudo apt-get clean && sudo apt-get autoremove && sudo apt-get --purge autoremove && sudo apt-get remove --purge $(deborphan) && sudo journalctl --vacuum-time=2weeks && rm -rf ~/.cache/thumbnails/*'
      fi

      # Rebuild
      if [ "$(grep '^NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '"')" = "NixOS" ]; then
        alias rebuild='sudo nixos-rebuild switch'
      elif [ "$(grep '^NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '"')" = "Ubuntu" ]; then
        alias rebuild='nix run nixpkgs#home-manager -- switch'
      fi

      # Upgrade
      if [ "$(grep '^NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '"')" = "NixOS" ]; then
        alias upgrade='sudo nix-channel --update && sudo nixos-rebuild switch --upgrade'
      elif [ "$(grep '^NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '"')" = "Ubuntu" ]; then
        alias upgrade='sudo apt -y update && sudo apt -y upgrade'
      fi

      # Digital Ocean Droplet Aliases
      alias dev="create-dev.sh"
      alias vpn="create-vpn.sh"
      alias droplet="create-droplet.sh"
      alias vdelete="delete-vpn.sh"
      alias ddelete="delete-droplets.sh"

      # Git Aliases
      alias gs='git status -s'
      alias ga='git add .'
      alias gb='git branch'
      alias gc='git commit'
      alias gd='git diff'
      alias go='git checkout'
      alias gk='gitk --all&'
      alias gx='gitx --all'

      # Alias definitions.
      # You may want to put all your additions into a separate file like
      # ~/.bash_aliases, instead of adding them here directly.
      # See /usr/share/doc/bash-doc/examples in the bash-doc package.

      if [ -f ~/.zsh_aliases ]; then
          . ~/.zsh_aliases
      fi

      # History settings
      export HISTSIZE=100000
      export HISTFILE="$HOME/.history"
      export HISTFILESIZE=2000
      export SAVEHIST=$HISTSIZE
      HISTTIMEFORMAT="%Y-%m-%d %T "
      HISTCONTROL=ignoreboth
    '';
  };
}
