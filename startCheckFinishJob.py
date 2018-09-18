#coding=utf-8
#Created by wyy on 2017-07-15.

import logging
import json
import random
import urllib2
from apscheduler.schedulers.background import BlockingScheduler
from dao.BaseDao import Session, with_session
from utils import RedisUtils
from utils import ConfigUtils
from utils.ConfigUtils import KEYMAP
from utils.JsonUtils import stringify
from dao import LoggerDao
from beans.TaskTable import TaskJob, TaskStatus, TaskJobHistory

user_agent_list = [\
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1"\
        "Mozilla/5.0 (X11; CrOS i686 2268.111.0) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11",\
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1092.0 Safari/536.6",\
        "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1090.0 Safari/536.6",\
        "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/19.77.34.5 Safari/537.1",\
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5",\
        "Mozilla/5.0 (Windows NT 6.0) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.36 Safari/536.5",\
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3",\
        "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3",\
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3",\
        "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3",\
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3",\
        "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3",\
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3",\
        "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3",\
        "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.0 Safari/536.3",\
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24",\
        "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24"
       ]

@with_session
def checkFinishJob():
    keys=RedisUtils.hkeys(ConfigUtils.getRedisPorperties(KEYMAP.FINISH_SPIDER_REDIS_KEY))
    for key in keys :
        temp=RedisUtils.hget(ConfigUtils.getRedisPorperties(KEYMAP.FINISH_SPIDER_REDIS_KEY), key)
        newJobTemplate=json.loads(temp)
        url=newJobTemplate['url']
        try:
            request = urllib2.Request(
                url=url,
                headers=(random.choice(user_agent_list))
            )
            response = urllib2.urlopen(request)
            urldate = response.headers['date']
            tempDate= newJobTemplate['urldate']
            print urldate
            print tempDate
            if urldate == tempDate:
                pass
            else:
                newJobTemplate['urldate']=urldate

                taskJobHistoryId = newJobTemplate['taskJobHistoryId']
                taskJobHistory=Session.query(TaskJobHistory).filter(TaskJobHistory.id==taskJobHistoryId,TaskJobHistory.delFlag==False).order_by(" create_time desc").first()
                taskJob=Session.query(TaskJob).filter(TaskJob.id==taskJobHistory.taskJobId).first()
                LoggerDao.addTaskJobLogger(taskJob,LoggerDao.LoggerType.URL_TO_REDIS,
                                           jobTemplateId=newJobTemplate['id'],taskJobHistoryId=taskJobHistoryId,
                                           content=u"redis_入库",url=url,status=TaskStatus.RUNNING)

                RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.ASSIST_SPIDER_REDIS_KEY), taskJobHistoryId)
                RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.ASSIST_SPIDER_REDIS_KEY) + "_" + taskJobHistoryId,stringify(newJobTemplate))
                RedisUtils.hset(ConfigUtils.getRedisPorperties(KEYMAP.FINISH_SPIDER_REDIS_KEY), newJobTemplate['id'],stringify(newJobTemplate))
        except Exception,e:
            pass
            print e

# checkFinishJob()
scheduler=BlockingScheduler()
scheduler.add_job(checkFinishJob, 'interval', minutes =60)
# scheduler.add_job(checkFinishJob, 'interval', seconds =15)
try:
    logging.info("interval scheduler.start minutes =60 checkFinishJob")
    scheduler.start()
except (KeyboardInterrupt, SystemExit):
    scheduler.shutdown()


