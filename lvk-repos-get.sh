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

# REPOS=: `ssh $GIT_DOMAIN 'ls '$GIT_DIR' | grep .git' ` 

#  Avoid unset variables act as empty strings and force scritp to abort if one
# is accesed 
set -o nounset

#functions

#Check arguments and existence of local directory of git's repository
checkArgs()
{
# TODO: Hacer case mas lindo ;)

  if [ ! $# -gt 0 ]; then
    paramHelp "$@"
    exit
  fi

  if [ ! -d $GIT_LOCAL_DIR ]
    then
      echo "the folder '$GIT_LOCAL_DIR' doesnt exist"
      exit
  fi

  if [ $# -eq 2 ]
    then
# TODO: verificar que el repo a pedir es un repo que existe
  #       if [ ! $2 in `ssh $GIT_DOMAIN ls $GIT_DIR | grep .git` ]
  # #       if [ ! $2 in $REPOS ]
  #       then
  # 	echo 'el repositorio '$2' no se encuentra en el servidor'
  # 	echo 'ejecute repos_get --list para ver los repositorios disponibles'
  # 	exit
  #       fi
    echo "no esta implementado el control sobre la existencia del repositorio solicitado"
    echo "ejecute repos_get --list para obtener una lista de los repositorios"
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
   echo " Using local '.lvkgit.cfg' insted of '$HOME/.lvk/.lvkgit.cfg' "
   echo "!!!!! \n"
   . ./.lvkgit.cfg
 fi
}

getAllRepos()
{
  cd $GIT_LOCAL_DIR
  for repo in `ssh $GIT_DOMAIN ls $GIT_DIR | grep .git`
  do
    echo 'Cloning '$repo' ...'
    git clone ssh://$GIT_DOMAIN/~/$GIT_DIR/$repo
  done
}

listRepos()
{
  for repo in `ssh $GIT_DOMAIN ls $GIT_DIR | grep .git`
  do
	  echo $repo
  done
}

getOneRepo()
{
  cd $GIT_LOCAL_DIR
  echo 'Cloning '$2' in '$GIT_LOCAL_DIR'...'
  git clone ssh://$GIT_DOMAIN/~/$GIT_DIR/$2
  echo "Done"

}

# TODO: Install man page and maybe remove paramHelp
paramHelp()
{
    echo "las opciones validas son las siguientes:"
    echo "-a | --all : Obtiene todos los repositorios exitentes en el servidor"
    echo "-g <NombreDelRepo> | --one <NombreDelRepo> : Obtiene el repostirio
    <NombreDelRepo>"
    echo "-l | --list : Lista los repositorios disponibles en el servidor"
    echo "------"
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
# TODO: -v|--version to show the version of script

#Process arguments 
for arg in "$@"
do
  case $arg in
    "-a"| "--all")
      echo "obtener todos los repositorios"
      getAllRepos "$@"
      exit;;
    "-g" | "--one")
      echo 'obteniendo el repositorio '$2''
      getOneRepo "$@"
      exit;;
    "-l" | "--list")
      echo " listando repositorios"
      listRepos "$@"
      exit;;
    "-h" | "--help")
      paramHelp "$@"
      exit;;
    *)
      paramHelp "$@"
      echo "Los repositorios disponibles son los siguientes:"
      listRepos "$@"
      exit
  esac
done

# End body of script

: <<'END_OF_DOCS'

=head1 NAME

lvk-repos-get.sh - Script to clone and setup git to work with repositories in
remote server

=head1 SYNOPSIS

lvk-repos-get.sh [-a|--all] [-g|--one repositorie] [-l|--list] [-h|--help]

=head1 OPTIONS

=head2 -a

Clone and setup all git repositories in server.

=head2 -g

Get and configure  one repositorie.

=head2 -l

List all avaiables repositories in remote server.

=head2 -v

show script version


=head1 DESCRIPTION

Please put full description here

=head2 ALGO

please put some subsection description here


=head1 LICENSE AND COPYRIGTH

GPL V 3

=head1 AUTHOR

arkatPDA @ Lvk

=cut

END_OF_DOCS
