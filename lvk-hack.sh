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

if [ $LVKDEBUG ]; then
  set -x
fi

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


