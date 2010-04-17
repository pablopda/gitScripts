#!/bin/sh -x
# git name-rev is fail
CURRENT=`git branch | grep '\*' | awk '{print $2}'`
# '/Users/arkatbrown/lvk/proyects/gitScripts'
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
        exit
else
        echo "Compilation error"
        echo "aborting ship"
        exit
fi

cd ..

git checkout master
git merge ${CURRENT}
git push origin master
git checkout ${CURRENT}


