#!/bin/sh
# -x for debbuging only
# For lvk interal use only
# Author arkatPDA @ lvk 


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


if [ ! -d $GIT_LOCAL_DIR ]
  then
      echo "the folder '$GIT_LOCAL_DIR' doesnt exist"
      exit
fi
cd $GIT_LOCAL_DIR
for repo in `ls`
do
	echo 'Pull (ing) '$repo' ...'
	cd $repo 
	git pull ssh://$GIT_DOMAIN/~/$GIT_DIR/$repo
	cd ..
done

# End body of script