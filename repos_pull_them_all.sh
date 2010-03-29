#!/bin/sh
GIT_DOMAIN=lvkgit@git.lavandaink.com.ar
GIT_DIR=git.lavandaink.com.ar
GIT_LOCAL_DIR=/home/arkat/lvk/reposborrar

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
