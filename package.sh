#!/bin/sh

# 获取当前目录名
dirName=`echo $(pwd)  | awk -F  \/ '{print $NF}'`

versionstr=`cat 1package.json  |  awk -F"[,:]" '{for(i=1;i<=NF;i++){if($i~/version\042/){print $(i+1)} } }'`
# 获取版本号
version=`echo $versionstr | sed 's/\"//g'`

# 打包
function package(){
	if [ ! -f "$dirName.$version.zip" ]; then 
		tar -cf /tmp/$dirName.tar  --exclude=".git/" --exclude="./$dirName.*.zip"  --exclude="./package.json" ./
		cp /tmp/$dirName.tar  ./
		zip $dirName.$version.zip $dirName.tar > /dev/null 2>&1
		rm $dirName.tar
	fi

	md5code=`md5 $dirName.$version.zip | awk   '{print $NF}'`
	newvsersion=`node signature.js $dirName.$version.zip`
	echo $newvsersion
}

# 如果没有传入老zip
if [ ! -n "$1" ] ;then
    	package
else
	# 如果传入的参数的文件不存在
	if [ ! -f "$1" ]; then 
    		package
	else
		# 如果文件存在就打包且生成增量包
		package
		echo $1-------------$newvsersion
		bsdiff $1 $dirName.$version.zip $dirName.$version.patch.zip
	fi
fi
