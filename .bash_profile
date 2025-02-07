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

# Ensure that these are only set once in the session login shell, not in subshells,
# even if the subshell is a login shell.  Subshells are sometimes login shells under
# systemd or gnome-shell, for example, and we don't want to do these things multiple
# times (e.g. appending a value to the PATH).
if [ ! -v BASH_PROFILE_SOURCED ]; then
	export BASH_PROFILE_SOURCED=1

	[ -d "$HOME/.pyenv/bin" ] && PATH="$HOME/.pyenv/bin:$PATH"
	type pyenv &>/dev/null && eval "$(pyenv init -)"
fi

# finally, source .bashrc if this is an interactive shell
# (bash only does this automatically for interactive non-login shells)
[[ $- == *i* ]] && [ -r "$HOME/.bashrc" ] && source "$HOME/.bashrc"
