# Bash automatically sources .bashrc when it is started as an interactive
# non-login shell, or when it is connected to a network connection, such as
# when started by rshd or sshd.  In addition, .bash_profile, which is the
# initialization file for bash login shells, sources ~/.bashrc if the shell is
# interactive.

# I use this file to hold any bash specific items that I want done for every
# interactive shell.  E.g. setting up command line editing, history, and
# completion.  Values that this shell instance might inherit from its parent
# should not be set here; default values can be set in .[bash_]profile.
# Also explicity source $ENV.

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

PROMPT_DIRTRIM=3

HISTCONTROL=ignoreboth
HISTFILESIZE=unlimited
HISTTIMEFORMAT="%F_%T "
HISTIGNORE="?:??:fg *:vim:nvim:exit:pwd:clear:mount:umount:history"
HISTSIZE=10000
shopt -s histappend
PROMPT_COMMAND+=('history -a')

if [ -r "$HOME/.git-prompt.sh" ]; then
	GIT_PS1_SHOWCOLORHINTS=yes
	GIT_PS1_SHOWDIRTYSTATE=yes
	GIT_PS1_DESCRIBE_STYLE=branch
	GIT_PS1_SHOWUPSTREAM=auto
	GIT_PS1_SHOWCONFLICTSTATE=yes
	GIT_PS1_SHOWSTASHSTATE=yes
	PROMPT_COMMAND+=('__git_ps1 "" "\u@\h:\w\$ " "(%s) "')
	source "$HOME/.git-prompt.sh"
else
	case $OSTYPE in
		cygwin) PS1="\\!:\\w\\$ ";;
		*) PS1="\!:\u@\h:\W\$ ";;
	esac
fi

# fzf Ctrl-R goodness
FZF_CTRL_R_OPTS=$'--bind ctrl-/:toggle-wrap --wrap-sign "\t↳ "'

# Enable the following tools in the current shell if they are available
[ -r "$XDG_CONFIG_HOME/fzf/fzf.bash" ] && source "$XDG_CONFIG_HOME/fzf/fzf.bash"
[ -r "$XDG_CONFIG_HOME/fzf-git/fzf-git.sh" ] && source "$XDG_CONFIG_HOME/fzf-git/fzf-git.sh"
type pyenv &>/dev/null && eval "$(pyenv init -)"
[ -r "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
