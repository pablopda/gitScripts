#!/bin/sh
# For lvk interal use only
# Author arkatPDA @ lvk 

#  Avoid unset variables act as empty strings and force scritp to abort if one
# is used
set -o nounset

#Initial Configuration

# checkConfig Check if configuration file exist
# if not make a new one with default configuration

checkConfig()
{
if [ -e "$HOME/.lvk/.lvkgit.cfg" ]; then
    echo "Using configuration file ${HOME}/.lvk/.lvkgit.cfg "
    echo "Please check yout ${HOME}/.lvk/.lvkgit.cfg against"
    echo "repository lvkgit.cfg for missing constant declarations"
else
    mkdir -p ~/.lvk
    touch ~/.lvk/.lvkgit.cfg
    echo '
# If you update gitScripts allways check new example configuration and correc
# this if is needed
readonly GIT_DOMAIN="lvkgit@git.lavandaink.com.ar"
readonly GIT_DIR="git.lavandaink.com.ar"
readonly GIT_LOCAL_DIR="$HOME/lvk/repos"

# Set where we put lvk binary git tools (and with that the man pages)
readonly GIT_SCRIPTS_DIR="$HOME/.lvk/gitScripts"

#Debug boolean variable
readonly LVKDEBUG=0

' >> ~/.lvk/.lvkgit.cfg
    echo "!!!!! ---- !!!!"
    echo "the lvkgit configuration wasn't exist, so we make it with the
default configuration"
    echo "please edit ~/.lvk/.lvkgit.cfg to adjust your local configuration"
    echo "!!!!! ---- !!!!"
      
fi
}

loadConfig()
{
 if [ ! -e "./.lvkgit.cfg" ]; then
    . $HOME/.lvk/.lvkgit.cfg
 else
   echo "\n!!!!!"
   echo " Using local '.lvkgit.cfg' insted of '$HOME/.lvk/.lvkgit.cfg' "
   echo "!!!!! \n"
   . ./.lvkgit.cfg
 fi
}

checkConfig "$@"
loadConfig "$@"

# if debug is set turn on xtrace
if [ $LVKDEBUG -eq 1 ]; then
  set -x
fi


#agrego el path para que sean ejecutables los scripts y accesibles las man
cat >>${HOME}/.bashrc <<eof
function pathmunge () {
if [ -d \$1 ] && ! echo $PATH | /bin/egrep -q "(^|:)\$1(\$|:)"
then
        if [ "\$2" = "after" ]
        then
                PATH=$PATH:\$1
        else
                PATH=\$1:\$PATH
        fi
fi
}

pathmunge ${HOME}/.lvk/gitScripts

eof


# End body of script

: <<'END_OF_DOCS'

=head1 NAME

lvk-initial-configuration.sh - Make initial configuration so u  can use the
lvk-git scripts

=head1 SYNOPSIS

lvk-initial-configuration.sh

=head1 OPTIONS

List all avaiables repositories in remote server.

=head2 -v

show script version

=head1 DESCRIPTION

Please put full description here

=head1 LICENSE AND COPYRIGTH

GPL V 3

=head1 AUTHOR

arkatPDA @ Lvk

=cut

END_OF_DOCS