#!/bin/sh
#GIT_DOMAIN=arkat@localhost
GIT_DOMAIN=lvkgit@git.lavandaink.com.ar
GIT_DIR=git.lavandaink.com.ar
#REPOS=: ssh $GIT_DOMAIN 'ls '$GIT_DIR' | grep .git' 

for repo in `ssh $GIT_DOMAIN ls $GIT_DIR | grep .git`
do
	echo 'Cloning '$repo' ...'
	git clone ssh://$GIT_DOMAIN/~/$GIT_DIR/$repo

done
#	git clone ssh://$GIT_DOMAIN/~/$GIT_DIR/$REPO
