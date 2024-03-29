#!/bin/sh 
#
# Author Pablo Perez De Angelis
# Copyright (C) Lvk Labs
 
# This file is part of gitScripts.
 
# gitScripts is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
 
# gitScripts is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

#  Avoid unset variables act as empty strings and force scritp to abort if one
# is used
# set -o nounset

#Initial Configuration

PROFILE="ERROR"

# checkConfig Check if configuration file exist
# if not make a new one with default configuration

checkConfig()
{
if [ -e "$HOME/.lvk/.lvkgit.cfg" ]; then
    echo "Using configuration file ${HOME}/.lvk/.lvkgit.cfg "
    echo "Please check yout ${HOME}/.lvk/.lvkgit.cfg against"
    echo "repository lvkgit.cfg for missing constant declarations"
else
	insertInitialConfig "#@"
    echo "!!!!! ---- !!!!"
    echo "the lvkgit configuration wasn't exist, so we make it with the
default values"
    echo "please edit ~/.lvk/.lvkgit.cfg to adjust your local and remote configuration"
    echo "!!!!! ---- !!!!"
      
fi
}

insertInitialConfig(){
    mkdir -p ~/.lvk
	touch ~/.lvk/.lvkgit.cfg
	echo '
# If you update gitScripts allways check new example configuration and correc
# this if is needed
readonly GIT_DOMAIN="user@yourdomain"
readonly GIT_DIR="directory_where_store_the_repos"
readonly GIT_LOCAL_DIR="$HOME/lvk/repos"

# Set where we put lvk binary git tools (and with that the man pages)
readonly GIT_SCRIPTS_DIR="$HOME/.lvk/gitScripts"

#Debug boolean variable
readonly LVKDEBUG=0
' >> ~/.lvk/.lvkgit.cfg
	
	if [ "`uname`" = "Linux" ]; then
		PROFILE=".bashrc"
	
	fi
	if [ "`uname`" = "Darwin" ]; then
		PROFILE=".profile"
	fi
	#agrego el path para que sean ejecutables los scripts y accesibles las man
# 	echo '
# function pathmunge () {
# if [ -d \$1 ] && ! echo $PATH | /bin/egrep -q "(^|:)\$1(\$|:)"
# then
#         if [ "\$2" = "after" ]
#         then
#                 PATH=$PATH:\$1
#         else
#                 PATH=\$1:\$PATH
#         fi
# fi
# }
# 
# pathmunge $HOME/.lvk/gitScripts
# 	' >> ${HOME}/${PROFILE}
	echo '
export PATH=$HOME/.lvk/gitScripts:$PATH	
export MANPATH=$HOME/.lvk/gitScripts/man:$MANPATH
' >> ${HOME}/${PROFILE}

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





# End body of script

: << 'END_OF_DOCS'

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
