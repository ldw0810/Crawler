# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html
import json
import uuid
from datetime import datetime

from scrapy import downloadermiddlewares

from beans.TaskTable import TaskJob, TaskStatus
from beans.UrlTable import UrlStatus
from dao import BaseDao
from dao import TaskJobDao
from dao import TemplateDao
from dao import UrlDao
from service import CrawlerService
from utils import ClassCopy
from utils import ConfigUtils
from utils import RedisUtils
from utils import RenderUtils
from utils.ConfigUtils import KEYMAP
from utils.DBClient import DbClient
from utils.JsonUtils import stringify
from utils.HdfsUtil import hdfs
import logging as logger

from utils.RedisUtils import llen


class GuizhoudemoPipeline(object):
    vat_factor = 1.15
    # downloadermiddlewares
    def process_item(self, item, spider):
        return item

    def open_spider(self, spider):
        print("打开爬虫了")

    def close_spider(self, spider):
        print("关闭爬虫了")
class DataBaseSavePipeline(object):
    def __init__(self):
        self.dbclient = DbClient()
        pass
    def process_item(self, item, spider):
        self._do_upinsert(item)
        return item

    def _do_upinsert(self, item):
        now = str(datetime.now())
        data = item["data"]
        jobTemplateFieldList=item["jobTemplateFieldList"]
        taskJob = item["taskJob"]
        taskJobHistroy = item["taskJobHistroy"]
        self.taskJobHistoryId =taskJob.taskJobHistoryId
        db = self.dbclient.getConnection(taskJob.databaseId)
        if not self.dbclient.isTableExist(taskJob.tableName):
            self.dbclient.createTable(taskJob.id,taskJob.tableName,jobTemplateFieldList)
        sqlArray=[]
        for d in data:
            parentId=taskJob.id
            sql=db.insert_sql(taskJob.tableName,item["taskJobId"],d)
            self.dbclient.execute(sql)
            if parentId!=None:
                childrenTaskJob=TaskJobDao.loadChildByParentId(parentId)
                self.loadNext(childrenTaskJob,{},d)

    def loadNext(self,childrenTaskJob,paramMap,item):
        if childrenTaskJob==None or len(childrenTaskJob)==0:
            return
        for taskJob in childrenTaskJob:
            CrawlerService.parseUrlAndInsertRedis(taskJob,item,taskJobHistory=self.taskJobHistoryId)
    def _handle_error(self, failue, item, spider):
        # self.log("==="+failue)
        print failue

class CacheHtmlPipeline(object):
    def __init__(self):
        print "init hdfs"
        self.default_hdfs_path = "/depthSpider/cache/html"
        self.hdfs = None
    def process_item(self, item, spider):
        try:
            curUrl = item["url"]
            subUrls = item["subUrls"]
            taskJob = spider.taskJob
            self.save_to_hdfs(taskJob.id,taskJob.databaseId,item["html"])
            taskJobHistory = spider.taskJobHistory
            if subUrls and len(subUrls)>0:
                parentUrlDepth = item["curUrlDepth"]
                for url in subUrls:
                    newTaskJob = ClassCopy.copyToNewInstances(taskJob,TaskJob)
                    newTaskJob.url=url
                    newTaskJob.curUrlDepth=parentUrlDepth+1
                    newTaskJob.parentUrl = curUrl
                    CrawlerService.parseUrlAndInsertRedis(newTaskJob, taskJobHistory=taskJobHistory)
            else:
                if llen(ConfigUtils.getRedisPorperties(KEYMAP.MAIN_SPIDER_REDIS_KEY)) == 0:
                    if taskJob.status != TaskStatus.SUCCESS:
                        TaskJobDao.updateTaskJobStatus(taskJob.id, TaskStatus.SUCCESS)
                        UrlDao.updateUrlStatusListByTaskJobHistoryId(spider.taskJobHistory.id, status=UrlStatus.STOP,
                                                                     desc="depth spider is over")
            return item
        except Exception,e:
            logger.exception("CacheHtmlPipeline:"+str(e))

    def save_to_hdfs(self,task_job_id,db_source_id,html):
        dbSource = TaskJobDao.queryDbSource(db_source_id)
        if dbSource:
            hdfs_host = dbSource.url
            hdfs_path = dbSource.dbname if dbSource.dbname else self.default_hdfs_path
            hdfs_path += task_job_id
            if self.hdfs and self.hdfs.host == hdfs_host:
                #原来已经初始化hdfs过了
                self.hdfs.save_to_hdfs2(hdfs_path,html)
            else:
                #原来没有初始化hdfs，或hdfs配置发生变化
                hdfs_param = {}
                hdfs_param['url'] = hdfs_host
                hdfs_param['dbname'] = hdfs_path
                self.hdfs = hdfs(hdfs_param)
                self.hdfs.save_to_hdfs2(hdfs_path,html)
        else:
            logger.error("CacheHtmlPipeline exception ,no hdfs dbSource")
# if __name__=="__main__":
#
#     jobTemplateParamList = TemplateDao.queryJobTemplateParamByJobTemplateIdType("85f33911-2368-11e7-a7d7-e09467f6dff0")
#     paramMap={"pageCount":168,"pageNum":180}
#     print DataBaseSavePipeline().paraseJobTemplateList(jobTemplateParamList,paramMap)