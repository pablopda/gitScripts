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

#  Avoid unset variables act as empty strings and force script to abort if one
# is used
set -o nounset

# git name-rev is fail
CURRENT=`git branch | grep '\*' | awk '{print $2}'`

#GITPATH=`pwd|rev|awk -F \/ '{print $1}'|rev`

GITNAME=`basename $PWD`

#check if projet compila
echo $GITNAME
mkdir -p tmp/
cd tmp

#git clone -b $CURRENT /Users/arkatbrown/lvk/proyects/gitScripts
git clone -b $CURRENT ../../$GITNAME

cd $GITNAME

xcodebuild 2> error.log > /dev/null

if [ ! -s "error.log" ]; then
        echo "all ok"
	cd ../../
	yes | rm -R tmp	
else
        echo "Compilation error"
        echo "aborting ship"
fi

#exit

git checkout master
git merge ${CURRENT}
git push origin master
git checkout ${CURRENT}
