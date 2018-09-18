#!/bin/sh
source ./setting.sh
cd ..
echo "path:"$REDIS_HOME
echo "停止redis：start"
processLog=process.log
logFile=logs/$processLog
nohup $REDIS_HOME/redis-cli shutdown  >> $logFile  2>&1 &
echo "停止redis：end"
processLog="process"
logFile="Spider.log"
process=`ps -ef|grep -E 'startFlask|startMainSpider|redis-server|startScvs|phantomjs|startDepthSpider|index|startPcInfo'|grep -v grep|grep -v PPID|awk '{ print $2}'`
echo $process
nohup echo $process>> logs/$processLog$logFile  2>&1
#if [ $process ]; then
    echo $process
    echo "停止爬虫进程$process"
    for i in $process;
    do
      nohup echo "Kill the $1 process [ $i ]" >> $logFile  2>&1
      kill -9 $i
    done
#fi
sleep 3