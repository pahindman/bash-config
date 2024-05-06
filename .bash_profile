# Bash automatically sources .bash_profile when started as an interactive login
# shell, or when started with --login
#
# I use this file for bash-specific stuff that needs to be done for a 'login'
# shell, and otherwise this file just sources the ~/.profile and ~/.bashrc

# first, source the .profile script, which is the corresponding startup file
# used when bash is started as sh, and so contains non-bash-specific items
if [[ -f ~/.profile ]]; then . ~/.profile; fi

# then source .bashrc (which bash only does automatically
# for interactive non-login shells)
if [[ $- == *i* && -f ~/.bashrc ]]; then . ~/.bashrc; fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
[[ -d $PYENV_ROOT/bin ]] && eval "$(pyenv init -)"

# finally, do any other bash specific items

