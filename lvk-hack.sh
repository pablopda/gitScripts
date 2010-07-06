#!/bin/sh 


if [$LVKDEBUG]; then
  set -x
fi
# For lvk interal use only
# Author arkatPDA @ lvk 

#  Avoid unset variables act as empty strings and force scritp to abort if one
# is used
set -o nounset



# git name-rev is fail
CURRENT=`git branch | grep '\*' | awk '{print $2}'`
if [ ${CURRENT} = "master" ]; then
  echo "you must hack branch not into master"
fi
git commit -a
git checkout master
git pull origin master
git checkout ${CURRENT}
git rebase master


