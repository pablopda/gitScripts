#!/bin/sh -x
# git name-rev is fail
xcodebuild 2> error.log > /dev/null
if [ ! -s "error.log" ]; then
	#echo "all ok"
	#exit
else
	echo "Compilation error"
	echo "aborting ship"
	exit
fi
CURRENT=`git branch | grep '\*' | awk '{print $2}'`
git checkout master
git merge ${CURRENT}
git push origin master
git checkout ${CURRENT}


