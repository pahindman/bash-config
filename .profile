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

# Enable the following tools in the current shell if they are available
[ -r "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -r "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
[ -r "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh"
[ -r "$XDG_CONFIG_HOME/nvm/nvm.sh" ] && . "$XDG_CONFIG_HOME/nvm/nvm.sh"
[ -r "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"

# If local bin dir is not in path then add it
if [ "${PATH#*$HOME/.local/bin}" == "${PATH}" ]; then
	export PATH=$HOME/.local/bin:$PATH
fi
