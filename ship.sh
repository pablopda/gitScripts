#!/bin/sh 
# -x for debbuging only
# For lvk interal use only
# Author arkatPDA @ lvk 

# git name-rev is fail
CURRENT=`git branch | grep '\*' | awk '{print $2}'`
git checkout master
git merge ${CURRENT}
git push origin master
git checkout ${CURRENT}


