{ pkgs, config, ... }:

{
  programs.bash = {
    enable = true;

    initExtra = ''

      # set a fancy prompt (non-color, unless we know we "want" color)
      case "$TERM" in
          xterm-color|*-256color) color_prompt=yes;;
      esac

      if [ -n "$force_color_prompt" ]; then
          if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
          else
        color_prompt=
          fi
      fi

      if [ "$color_prompt" = yes ]; then
          PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
      else
          PS1='\u@\h:\w\$ '
      fi
      unset color_prompt force_color_prompt

      # enable color support of ls and also add handy aliases
      if [ -x /usr/bin/dircolors ]; then
          test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
          #alias ls='ls --color=auto'
          #alias dir='dir --color=auto'
          #alias vdir='vdir --color=auto'

          alias grep='grep --color=auto'
          alias fgrep='fgrep --color=auto'
          alias egrep='egrep --color=auto'
      fi

      # If this is an xterm set the title to user@host:dir
      case "$TERM" in
      xterm*|rxvt*)
          PS1="\[\e]0;\\u@\h: \w\a\]$PS1"
          ;;
      *)
          ;;
      esac

      # --- setup fzf ---
      # fzf key bindings and fuzzy completion
      eval "$(fzf --bash)"

      # --- setup fzf theme --- https://github.com/catppuccin/fzf
      export FZF_DEFAULT_OPTS=" \
      --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
      --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
      --color=selected-bg:#45475a \
      --multi \
      --height 40% \
      --layout=reverse"

      # Zoxide initialization
      eval "$(zoxide init bash)"

      # Bindings for Bash
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
      bind '"\e[C": forward-char'
      bind '"\e[D": backward-char'

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
      alias l="ls -laF"       # List in long format, include dotfiles
      alias ls="ls -laF --color=auto"       # List in long format, include dotfiles
      alias ld="ls -ld */"   # List in long format, only directories
      alias nnn='nnn -de'
      alias lzd='lazydocker'
      alias fzf='fzf --preview="bat --color=always {}"'
      # Open multiple files in VSCode/NeoVim [Tab to select, ENTER to open in VSCode]
      alias cfzf='code $(fzf -m --preview="bat --color=always {}")'
      alias nfzf='nvim $(fzf -m --preview="bat --color=always {}")'

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

      # enable programmable completion features (you don't need to enable
      # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
      # sources /etc/bash.bashrc).
      if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
          . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
          . /etc/bash_completion
        fi
      fi
    '';
  };
}
