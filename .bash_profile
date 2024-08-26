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

# then source .bashrc (which bash only does automatically
# for interactive non-login shells)
[[ $- == *i* ]] && [ -r "$HOME/.bashrc" ] && source "$HOME/.bashrc"

# finally, do any other bash specific items

PYENV_ROOT="$HOME/.pyenv"
[ -d "$PYENV_ROOT/bin" ] && PATH="$PYENV_ROOT/bin:$PATH"
type pyenv &>/dev/null && eval "$(pyenv init -)"

