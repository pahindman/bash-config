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
#
# Commands that must be run even for non-login shells (for example, settings
# that are not inherited) should be put in the file named by the ENV variable.
ENV=$HOME/.shinit; export ENV

export PATH

# Add my personal programs to the path
PATH=~/.local/bin:$PATH

if [ ! -d "$XDG_CONFIG_HOME" ]; then
  export XDG_CONFIG_HOME="$HOME/.config"
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
