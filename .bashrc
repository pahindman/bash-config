# Bash automatically sources .bashrc when it is started as an interactive
# non-login shell, or when it is connected to a network connection, such as
# when started by rshd or sshd.  In addition, .bash_profile, which is the
# initialization file for bash login shells, sources ~/.bashrc if the shell is
# interactive.

# I use this file to hold any bash specific items that I want done for every
# interactive shell.  E.g. setting up command line editing, history, and
# completion.  Values that this shell instance might inherit from its parent
# should not be set here; default values can be set in .[bash_]profile.
# Also explicity source $ENV, which is set in .profile.

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# First, source bourne shell ENV file
[ -r "$ENV" ] && source "$ENV"

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

[ -r "$HOME/.nvm/bash_completion" ] && source "$HOME/.nvm/bash_completion"

shopt -s histappend

# Enable the following tools in the current shell if they are available
[ -r "$XDG_CONFIG_HOME/fzf/fzf.bash" ] && source "$XDG_CONFIG_HOME/fzf/fzf.bash"
[ -r "$XDG_CONFIG_HOME/fzf-git/fzf-git.sh" ] && source "$XDG_CONFIG_HOME/fzf-git/fzf-git.sh"
[ -r "$HOME/.git-prompt.sh" ] && source "$HOME/.git-prompt.sh"
[ -r "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
