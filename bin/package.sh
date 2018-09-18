#!/bin/sh
profile=$1
if [ ! not $profile];then
    profile=""
fi
cd ..
var=`pwd`
projectName=${var##*/}
echo "删除.pyc文件"
find ./ -name "*.pyc"| xargs rm -rf
sed -i "s/Profile=\"[a-z]*\"/Profile=\"$profile\"/g" Settings.py
cd ..
echo "拷贝Crawler start"
echo `pwd`
rm -rf dist
mkdir dist
echo "拷贝",$projectName
cp $projectName dist/Crawler -R
#rsync -av --exclude Crawler/.svn --exclude Crawler/.idea Crawler CrawlerPackage
echo "拷贝Crawler end"
cd dist/Crawler/
echo `pwd`
python -m compileall ./
echo "删除idea文件"
rm -rf .idea
echo "删除svn文件"
rm -rf .svn
find ./ -name "*.py"| xargs rm -rf
cd ..
echo "开始打包"
rm -rf Crawler.tar.gz
tar -czf Crawler.tar.gz Crawler
#echo "删除temp包"
#rm -rf Crawler
#echo "打包完成"