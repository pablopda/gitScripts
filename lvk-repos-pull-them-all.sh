#!/bin/sh 
# For lvk interal use only
# Author arkatPDA @ lvk 

#  Avoid unset variables act as empty strings and force scritp to abort if one
# is used
set -o nounset

#Functions:

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


#End functions ---

# Body of script
checkConfig "$@"
loadConfig "$@"

# if debug is set turn on xtrace
if [ $LVKDEBUG -eq 1 ]; then
  set -x
fi

if [ ! -d $GIT_LOCAL_DIR ]
  then
      echo "the folder '$GIT_LOCAL_DIR' doesnt exist"
      exit
fi

# For each repositorie in GIT_LOCAL_REPO pull the origin master into local
# master branch

cd $GIT_LOCAL_DIR

# TODO : impruve (maybe) search only for directories with .git sub directory
for repo in `ls -d */` 				# `ls -d */` list only directories
do
	echo 'Pull (ing) '$repo' ...'
	cd $repo
	CURRENT=`git branch | grep '\*' | awk '{print $2}'`
	if [ ! ${CURRENT} = "master" ]; then
		git checkout master
		git pull origin master
		git checkout ${CURRENT}
	else
		# pull from origin the master branch into current branch
		git pull origin master
	fi
	#git pull ssh://$GIT_DOMAIN/~/$GIT_DIR/$repo master
	#hack.sh
	cd ..
done

# End body of script

: <<'END_OF_DOCS'

=head1 NAME

lvk-repos-pull-them-all.sh - Script to pull all master branch of yours 
lvk-git repos allready cloned from the server into your repos directory 

=head1 SYNOPSIS

lvk-repos-pull-them-all.sh

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
