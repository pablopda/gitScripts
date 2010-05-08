#!/bin/sh 
# -x for debbuging only
# For lvk interal use only
# Author arkatPDA @ lvk 

# git name-rev is fail
CURRENT=`git branch | grep '\*' | awk '{print $2}'`
git commit -a
git checkout master
git pull origin master
git checkout ${CURRENT}
git rebase master


