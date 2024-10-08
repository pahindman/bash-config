# Bash automatically sources .bash_profile when started as an interactive login
# shell, or when started with --login
#
# I use this file for bash-specific stuff that needs to be done for a 'login'
# shell, e.g. the sane defaults for environment variables. These default values
# can be overridden before executing subshells, and the subshells will
# (typically) use the new values rather than these defaults because they won't
# be login shells, so won't source this file.  Initialization that must be done
# even for non-login shells (for example, settings that are not inherited)
# should be put in .bashrc.
#
# Otherwise this file just sources the ~/.profile and ~/.bashrc

# first, source the .profile script, which is the corresponding startup file
# used when bash is started as sh, and so contains non-bash-specific items
[ -r "$HOME/.profile" ] && source "$HOME/.profile"

# then do bash specific items

PYENV_ROOT="$HOME/.pyenv"
[ -d "$PYENV_ROOT/bin" ] && PATH="$PYENV_ROOT/bin:$PATH"
type pyenv &>/dev/null && eval "$(pyenv init -)"

NVM_DIR="$HOME/.nvm"
[ -r "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -r "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

export PROMPT_DIRTRIM=3

if [ -r "$HOME/.git-prompt.sh" ]; then
	export GIT_PS1_SHOWCOLORHINTS=yes
	export GIT_PS1_SHOWDIRTYSTATE=yes
	export GIT_PS1_DESCRIBE_STYLE=branch
	export GIT_PS1_SHOWUPSTREAM=auto
	export GIT_PS1_SHOWCONFLICTSTATE=yes
	export GIT_PS1_SHOWSTASHSTATE=yes
	export PROMPT_COMMAND='__git_ps1 "" "\u@\h:\w\$ " "(%s) "'
else
	case $OSTYPE in
		cygwin) export PS1="\\!:\\w\\$ ";;
		*) export PS1="\!:\u@\h:\W\$ ";;
	esac
fi

export HISTCONTROL=ignoreboth
export HISTFILESIZE=100000
export HISTIGNORE="?:??:fg ?:vim:nvim:exit:pwd:clear:mount:umount:history"
export HISTSIZE=10000

# finally, source .bashrc if this is an interactive shell
# (bash only does this automatically for interactive non-login shells)
[[ $- == *i* ]] && [ -r "$HOME/.bashrc" ] && source "$HOME/.bashrc"
