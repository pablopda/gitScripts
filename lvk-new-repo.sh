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
# -x for debbuging only

#  Avoid unset variables act as empty strings and force scritp to abort if one
# is used
set -o nounset

#Functions:

# Check arguments

checkArgs()
{
NO_ARGS=0
E_OPTERROR=65

if [ $# -eq "$NO_ARGS" ]; then
	echo '---'
	echo "You must give a repository name"
        echo "Usage: ./new_repo nameOfTheRepo "
	echo ''
        exit $E_OPTERROR
fi

if [ ! -d $GIT_LOCAL_DIR ]; then
	echo '---'
	echo 'The folder '$GIT_LOCAL_DIR' doent exist'
	echo ''
	exit
fi
}

# Check if configuration file exist
checkConfig()
{
 if [ ! -e "$HOME/.lvk/.lvkgit.cfg" ]; then
    echo "!!!!! ---- !!!!"
    echo "Please run lvk-initial-configuration.sh before start using the scripts"
    echo "!!!!! ---- !!!!"
    exit
 fi
}

loadConfig()
{
 if [ ! -e "./.lvkgit.cfg" ]; then
    . $HOME/.lvk/.lvkgit.cfg
 else
   echo "\n!!!!!"
   echo " Using current directory '.lvkgit.cfg' insted of '$HOME/.lvk/.lvkgit.cfg' "
   echo "!!!!! \n"
   . ./.lvkgit.cfg
 fi
}


#End functions

# Body of script

checkConfig "$@"
loadConfig "$@"
checkArgs "$@"


# if debug is set turn on xtrace
if [ $LVKDEBUG -eq 1 ]; then
  set -x
fi


ssh $GIT_DOMAIN 'mkdir -p  ~/'$GIT_DIR'/'$1'.git && cd ~/'$GIT_DIR'/'$1'.git && git --bare init'
cd $GIT_LOCAL_DIR
mkdir $1
cd $1
git init
@git remote add origin ssh://$GIT_DOMAIN/~/$GIT_DIR/$1.git
git remote add origin ssh://$GIT_DOMAIN/~/$GIT_DIR/$1.git
touch .gitignore
git add .
git commit -m 'Created new repo'
git push origin master
echo "
[branch \"master\"]
  remote = origin
  merge = refs/heads/master" >>.git/config
echo "new git repo '$1' ready  @ $GIT_DOMAIN/$GIT_DIR/$1.git"

# End body of script

: <<'END_OF_DOCS'

=head1 NAME

lvk-new-repo.sh - Create a new git repo in remote server

=head1 SYNOPSIS

lvk-new-repo.sh newRepoName

=head1 OPTIONS

=head2 -v

show script version


=head1 DESCRIPTION

Please put full description here


=head1 LICENSE AND COPYRIGTH

GPL V3

=head1 AUTHOR

arkatPDA @ Lvk

=cut

END_OF_DOCS
