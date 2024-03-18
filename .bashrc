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

# Use bash-it if it is installed
if [ -x $HOME/.bash_it/bash_it.sh ]; then
   # Path to the bash it configuration
   export BASH_IT=$HOME/.bash_it

   # Lock and Load a custom theme file
   # location /.bash_it/themes/
   export BASH_IT_THEME='phil'

   # Load Bash It
   . $BASH_IT/bash_it.sh
else
   case $OSTYPE in
      cygwin) PS1="\\!:\\w\\$ ";;
      *) PS1="\!:\u@\h:\W\$ ";;
   esac
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
