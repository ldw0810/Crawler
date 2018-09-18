#!/bin/sh
source ./setting.sh
cd ..
logFile="Spider.log"
processLog="process.log"
echo "停止redis：start"
nohup $REDIS_HOME/redis-server  >> logs/$processLog  2>&1 &
echo "停止redis：end"
processNum=$1
if [ ! $processNum ];then
    processNum=2
fi
# -E表示为包含一个
process=`ps -ef|grep -E 'startFlask|startMainSpider|startScvs|phantomjs|startDepthSpider|index|startPcInfo'|grep -v grep|grep -v PPID|awk '{ print $2}'`
echo $process
nohup echo $process>> logs/$processLog 2>&1
#if [ $process ]; then
    for i in $process;
    do
      nohup echo "Kill the $1 process [ $i ]" >> logs/$logFile  2>&1
      kill -9 $i
    done
#fi
nohup python startFlask.pyc >> logs/flask.log 2>&1 &
nohup python startScvs.pyc >> logs/scvs.log 2>&1 &
nohup python ./customize_app/test_app/webApp/index.pyc >> logs/scvs.log 2>&1 &
nohup python startDepthSpider.pyc >> logs/scvs.log 2>&1 &
nohup python startPcInfo.pyc >> logs/pcInfo.log 2>&1 &
for ((i=0;i<$processNum;i++))
do
   fileName=$logFile$i
    path=logs/$fileName
    echo "开启第$i爬虫线程"  >> $path 2>&1
    nohup python startMainSpider.pyc >>  $path  2>&1 &
    echo "第$i爬虫线程完毕"  >> $path 2>&1
done

