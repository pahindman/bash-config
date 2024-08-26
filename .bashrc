# Bash automatically sources .bashrc when it is started as an interactive
# non-login shell, or when it is connected to a network connection, such as
# when started by rshd or sshd.  In addition, .bash_profile, which is the
# initialization file for bash login shells, sources ~/.bashrc if the shell is
# interactive.

# I use this file to hold any bash specific items that I want done for every
# interactive shell.  E.g. setting up command line editing, history, and
# completion.

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# Source system-wide aliases and functions
[ -r /etc/bashrc ] && source /etc/bashrc
[ -r /etc/bash.bashrc ] && source /etc/bash.bashrc

if ! shopt -oq posix; then
  if [ -r /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -r /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

set -o ignoreeof
set -o vi

if [ -r "$HOME/.git-prompt.sh" ]; then
   GIT_PS1_SHOWCOLORHINTS=yes
   GIT_PS1_SHOWDIRTYSTATE=yes
   GIT_PS1_DESCRIBE_STYLE=branch
   GIT_PS1_SHOWUPSTREAM=auto
   GIT_PS1_SHOWCONFLICTSTATE=yes
   GIT_PS1_SHOWSTASHSTATE=yes
   # Load the git prompt script
   source "$HOME/.git-prompt.sh"
   PROMPT_COMMAND='__git_ps1 "" "\u@\h:\w\$ " "(%s) "'
else
   case $OSTYPE in
      cygwin) PS1="\\!:\\w\\$ ";;
      *) PS1="\!:\u@\h:\W\$ ";;
   esac
fi

# use dircolors to set LS_COLORS
if [ -x /usr/bin/dircolors ]; then
    [ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PROMPT_DIRTRIM=3
export DISPLAY=:0

if type nvim &> /dev/null; then
   export EDITOR=nvim
   export VISUAL=nvim
elif type vim &> /dev/null; then
   export EDITOR=vim
   export VISUAL=vim
fi

shopt -s histappend
HISTCONTROL=ignoreboth
HISTFILESIZE=100000
HISTIGNORE="?:??:fg ?:vim:nvim:exit:pwd:clear:mount:umount:history"
HISTSIZE=10000

[ -r "$HOME/.fzf.bash" ] && source "$HOME/.fzf.bash"
[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.bash" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.bash"
[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/fzf-git/fzf-git.sh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/fzf-git/fzf-git.sh"
[ -r "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -r "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
[ -r "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
