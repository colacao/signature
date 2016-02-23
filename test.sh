#!/bin/sh
dirName=`echo $(pwd)  | awk -F  \/ '{print $NF}'`
tar -cf /tmp/$dirName.tar  --exclude .git/ --exclude ./$dirName.zip  --exclude  ./package.json ./
cp /tmp/$dirName.tar  ./
zip $dirName.zip $dirName.tar > /dev/null 2>&1
rm $dirName.tar
md5code=`md5 $dirName.zip | awk   '{print $NF}'`
echo $md5code