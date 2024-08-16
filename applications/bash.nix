{ pkgs, config, ... }:

{
  programs.bash = {
    enable = true;

    initExtra = ''

      # Bindings
      bindkey "\e[A": history-search-backward
      bindkey "\e[B": history-search-forward
      bindkey "\e[C": forward-char
      bindkey "\e[D": backward-char
      bindkey '^f' autosuggest-accept

      # Alias
      alias ..="cd .."
      alias ...="cd ../.."
      alias ....="cd ../../.."
      alias c="clear"
      alias e="exit"
      alias n="nvim"
      alias t="tmux"
      alias tn="(){tmux new -s $1}"
      alias p="pnpm"
      alias ls='nnn -de'
      alias lzd='lazydocker'

      # Digital Ocean Droplet Aliases
      alias dev="create-dev.sh"
      alias vpn="create-vpn.sh"
      alias droplet="create-droplet.sh"
      alias vdelete="delete-vpn.sh"
      alias ddelete="delete-droplets.sh"

      # Git Aliases
      alias gs='git status -s'
      alias ga='git add .'
      alias gb='git branch '
      alias gc='git commit'
      alias gd='git diff'
      alias go='git checkout '
      alias gk='gitk --all&'
      alias gx='gitx --all'
      
      # History settings
      export HISTSIZE=100000
      export HISTFILE="$HOME/.history"
      export SAVEHIST=$HISTSIZE
      HISTTIMEFORMAT="%Y-%m-%d %T "
      HISTCONTROL=ignoreboth
    '';
  };
}
