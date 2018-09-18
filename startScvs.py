#coding=utf-8
#Created by wyy on 2017-06-27.

import logging
import datetime
from apscheduler.schedulers.background import BlockingScheduler
from beans.TemplateTable import CrawlerDataListener
from dao.TemplateDao import JobTemplate
from dao.BaseDao import Session, with_session
from dao import BaseDao
import json
import uuid

def addCrawlerDataListener(num,totle):
    date = datetime.datetime.now()
    time = date.strftime("%H:%M")
    cdl = CrawlerDataListener()
    cdl.id = str(uuid.uuid4())
    cdl.count = num
    cdl.time = time
    cdl.totle = totle
    cdl.createTime = date
    logging.info("addCrawlerDataListener  BaseDao.add")
    BaseDao.add(cdl)

def queryTableCount(jobTemplate):
    from utils.DBClient import DbClient
    db = DbClient()
    slavedb = db.getConnection(jobTemplate.databaseId)
    rs=json.loads(slavedb.query_collect_index(db.dbparms['dbname'],jobTemplate.tableName))
    if rs is not None and len(rs) > 0:
        return sum(rs[0])
    else:
        return 0
    pass
@with_session
def runListener():
    TemplateList = Session.query(JobTemplate).all()
    count=0
    totle=0
    for t in TemplateList:
        count+=queryTableCount(t)
    pass
    print count
    rs=Session.query(CrawlerDataListener).order_by(CrawlerDataListener.createTime.desc()).limit(1).all()
    if len(rs)>0:
        totle=rs[0].totle
        p=count-int(totle)
        addCrawlerDataListener(p, count)
    else:
        addCrawlerDataListener(0,count)
    logging.info("runListener  BaseDao.add")


scheduler=BlockingScheduler()
scheduler.add_job(runListener, 'interval', minutes =30)
# scheduler.add_job(runListener, 'interval', seconds =15)
try:
    logging.info("interval scheduler.start runListener addCrawlerDataListener")
    scheduler.start()
except (KeyboardInterrupt, SystemExit):
    scheduler.shutdown()