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

      # --- setup powerlevel10k ---
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
      export HISTFILE="$HOME/.history"
      export HISTFILESIZE=2000
      export SAVEHIST=$HISTSIZE
      HISTTIMEFORMAT="%Y-%m-%d %T "
      HISTCONTROL=ignoreboth
    '';
  };
}
