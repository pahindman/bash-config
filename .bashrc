# Bash automatically sources .bashrc when it is started as an interactive
# non-login shell, or when it is connected to a network connection, such as
# when started by rshd or sshd.  In addition, .bash_profile, which is the
# initialization file for bash login shells, sources ~/.bashrc if the shell is
# interactive.

# I use this file to hold any bash specific items that I want done for every
# interactive shell.  E.g. setting up command line editing, history, and
# completion.

# Source system-wide aliases and functions
if [ -f /etc/bashrc ]; then
   . /etc/bashrc
fi
if [ -f /etc/bash.bashrc ]; then
   . /etc/bash.bashrc
fi


if [ -f /opt/local/etc/bash_completion ]; then
   . /opt/local/etc/bash_completion
fi

if [ -f ~/macports/etc/profile.d/bash_completion.sh ]; then
   . ~/macports/etc/profile.d/bash_completion.sh
fi

set -o ignoreeof
set -o vi

export HISTCONTROL=ignoreboth

# Use bash-it if it is installed
if [ -x $HOME/.bash_it/bash_it.sh ]; then
   # Path to the bash it configuration
   export BASH_IT=$HOME/.bash_it

   # Lock and Load a custom theme file
   # location /.bash_it/themes/
   export BASH_IT_THEME='phil'

   # Load Bash It
   . $BASH_IT/bash_it.sh
elif [ -x $HOME/.git-prompt.sh ]; then
   GIT_PS1_SHOWCOLORHINTS=yes
   GIT_PS1_SHOWDIRTYSTATE=yes
   GIT_PS1_DESCRIBE_STYLE=branch
   GIT_PS1_SHOWUPSTREAM=auto
   GIT_PS1_SHOWCONFLICTSTATE=yes
   GIT_PS1_SHOWSTASHSTATE=yes
   # Load the git prompt script
   . $HOME/.git-prompt.sh
   PROMPT_COMMAND='__git_ps1 "" "\u@\h:\w\$ " "(%s) "'
else
   case $OSTYPE in
      cygwin) PS1="\\!:\\w\\$ ";;
      *) PS1="\!:\u@\h:\W\$ ";;
   esac
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PROMPT_DIRTRIM=3
export DISPLAY=:0

# If nvim is installed, use it as the default editor
# Otherwise, use vim if it is installed
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

# setup fzf if it is installed
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash

# setup cargo if it is installed
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
