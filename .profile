# The Bourne Shell (or bash when it invoked with the name 'sh') sources
# ~/.profile when it is started as an interactive login shell, or when started
# with --login.  In addition, .bash_profile, which is the corresponding file
# for bash login shells, sources ~/.profile.
#
# This file contains non-bash specific items that need to be done for a login
# shell -- typically setting up the initial values for environment variables.
# These default values can be overridden before executing subshells, and the
# subshells will (typically) use the new values rather than these defaults
# because they won't be login shells, so won't source this file.

if [ ! -d "$XDG_CONFIG_HOME" ]; then
	export XDG_CONFIG_HOME="$HOME/.config"
fi

if [ ! -d "$XDG_DATA_HOME" ]; then
	export XDG_DATA_HOME="$HOME/.local/share"
fi

if type nvim &> /dev/null; then
	export EDITOR=nvim
	export VISUAL=nvim
elif type vim &> /dev/null; then
	export EDITOR=vim
	export VISUAL=vim
fi

# Ensure that these are only set once in the session login shell, not in subshells,
# even if the subshell is a login shell.  Subshells are sometimes login shells under
# systemd or gnome-shell, for example, and we don't want to do these things multiple
# times (e.g. appending a value to the PATH).
if [ ! -v SH_PROFILE_SOURCED ]; then
	export SH_PROFILE_SOURCED=1

	# Enable the following tools in the current shell if they are available
	[ -r "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
	[ -r "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
	[ -r "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh"
	[ -r "$XDG_CONFIG_HOME/nvm/nvm.sh" ] && . "$XDG_CONFIG_HOME/nvm/nvm.sh"

	# Add my personal programs to the path
	export PATH=~/.local/bin:$PATH
fi
