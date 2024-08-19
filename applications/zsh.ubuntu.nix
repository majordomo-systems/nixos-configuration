{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "docker-compose" "docker" "git" "history" "dirhistory" "node" "npm" "z" "fzf" "sudo" "web-search" "copypath" "copyfile" "jsontools"];
      theme = "dst";
    };
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # set a fancy prompt (non-color, unless we know we "want" color)
      case "$TERM" in
          xterm-color|*-256color) color_prompt=yes;;
      esac

      if [ -n "$force_color_prompt" ]; then
          if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            color_prompt=yes
          else
            color_prompt=
          fi
      fi

      if [ "$color_prompt" = yes ]; then
          PS1='\033[01;32m\u@\h\033[00m:\033[01;34m\w\033[00m\$ '
      else
          PS1='\u@\h:\w\$ '
      fi
      unset color_prompt force_color_prompt

      # enable color support of ls and also add handy aliases
      if [ -x /usr/bin/dircolors ]; then
          test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
          alias grep='grep --color=auto'
          alias fgrep='fgrep --color=auto'
          alias egrep='egrep --color=auto'
      fi
      
      # If this is an xterm set the title to user@host:dir
      case "$TERM" in
      xterm*|rxvt*)
          PS1="%{\e]0;%n@%m: %~\a%}$PS1"
          ;;
      *)
          ;;
      esac

      # ---- FZF -----

      # Set up fzf key bindings and fuzzy completion
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh

      # --- setup fzf theme ---
      export FZF_DEFAULT_OPTS="--color=fg:#CDD6F4,bg:#1E1E2E,hl:#F5C2E7,fg+:#CDD6F4,bg+:#302D41,hl+:#F5C2E7,info:#94E2D5,prompt:#F28FAD,pointer:#F28FAD,marker:#F28FAD,spinner:#94E2D5,header:#B4BEFE --height 40% --layout=reverse"

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
      alias nv="nvim"
      alias t="tmux"
      alias tn="(){ tmux new -s \$1 }"
      alias p="pnpm"
      alias l="ls -laF"       # List in long format, include dotfiles
      alias ls="ls -laF --color=auto"       # List in long format, include dotfiles
      alias ld="ls -ld */"   # List in long format, only directories
      alias nnn='nnn -de'
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

      if [ -f ~/.bash_aliases ]; then
          . ~/.bash_aliases
      fi

      # History settings
      export HISTSIZE=100000
      export HISTFILE="\$HOME/.history"
      export HISTFILESIZE=2000
      export SAVEHIST=\$HISTSIZE
      HISTTIMEFORMAT="%Y-%m-%d %T "
      HISTCONTROL=ignoreboth
    '';
  };
}
