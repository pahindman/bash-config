# The Bourne Shell (or bash when it invoked with the name 'sh') sources
# ~/.profile when it is started as an interactive login shell, or when started
# with --login.  In addition, .bash_profile, which is the corresponding file
# for bash login shells, sources ~/.profile.
#
# This file contains non-bash specific items that need to be done for a login
# shell -- typically setting up the initial values for environment variables.
export PATH
# Add macports folders to the PATH
PATH=~/macports/bin:~/macports/sbin:$PATH
# Add my personal programs to the path
PATH=~/bin:$PATH

# CLICOLOR tells ls to use in its output.
export CLICOLOR; CLICOLOR=1

P4CONFIG=.p4config
export P4CONFIG

