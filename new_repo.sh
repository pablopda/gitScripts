#!/bin/sh
# For lvk interal use only
#GIT_DOMAIN=arkat@localhost
GIT_DOMAIN=lvkgit@git.lavandaink.com.ar
GIT_DIR=git.lavandaink.com.ar
GIT_LOCAL_DIR=/home/arkat/lvk/proyects/

#Functions 
checkargs()
{
NO_ARGS=0
E_OPTERROR=65

if [ $# -eq "$NO_ARGS" ] 
then
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


# Body of script

checkargs "$@"

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

