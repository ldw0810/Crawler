# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html
import os
import uuid
from datetime import datetime
from Settings import KEYMAP
from beans.TaskTable import TaskJobHistory, TaskJobParam, TaskStatus
from beans.UrlTable import UrlStatus
from dao import TaskJobDao
from dao import TemplateDao
from dao import UrlDao
from service import CrawlerService
from service.h_pc.getpcinfo import Pcinfo
from utils import ConfigUtils
from utils import RedisUtils
from utils.DBClient import DbClient

import time

from utils.RedisUtils import llen
import logging

class DataBaseSavePipeline(object):
    def __init__(self):
        self.dbclient = DbClient()
        logging.info('*********DataBaseSavePipeline init****************************')
        pass
    def process_item(self, item, spider):
        self._do_upinsert(item)
        return item

    def _do_upinsert(self, item):
        now = str(datetime.now())
        data = item["data"]
        url = item["url"]
        jobTemplateFieldList=item["jobTemplateFieldList"]
        jobTemplate = item["jobTemplate"]
        self.dataParentId=jobTemplate.dataParentId if hasattr(jobTemplate,"dataParentId") else None
        extraData=jobTemplate.extraData
        self.taskJob = item["taskJob"]
        # searchTaskJob = item["searchTaskJob"]
        taskJobHistroy = item["taskJobHistroy"]
        self.taskJobHistoryId=jobTemplate.taskJobHistoryId
        taskJobHistroyId=str(taskJobHistroy.id)
        paramMap={}
        self.taskJobParamList=[]
        if taskJobHistroy!=None:
            self.taskJobParamList.append(TaskJobParam(paramNameEn="task_job_id_sequence",paramValue=taskJobHistroyId))
            paramMap["task_job_id_sequence"] = taskJobHistroyId
        # if searchTaskJob!=None:
        #     self.taskJobParamList.append(TaskJobParam(paramNameEn=searchTaskJob.name, paramValue=searchTaskJob.name))
        #     paramMap[searchTaskJob.name] = searchTaskJob.name
        # self.taskJobParamList = []
        # if self.taskJobHistoryId!=None:
        #     self.taskJobParamList=CacheFactory.get("task_job_param", self.taskJobHistoryId)
        # if self.taskJobParamList!=None:
        #     for taskJobParam in self.taskJobParamList:
        #         paramMap[taskJobParam.paramNameEn]=taskJobParam.paramValue
        tableName=jobTemplate.tableName
        jobTemplateId=jobTemplate.id
        databaseId= jobTemplate.databaseId if jobTemplate.databaseId!="-1" and jobTemplate.databaseId!=None else self.taskJob.databaseId
        db = self.dbclient.getConnection(databaseId)

        if db==None:
            logging.warning('db is null,please check it with databaseid :%s' % databaseId)
            if llen(ConfigUtils.getRedisPorperties(KEYMAP.MAIN_SPIDER_REDIS_KEY)) == 0:
                if self.taskJob.status != TaskStatus.SUCCESS:
                    TaskJobDao.updateTaskJobStatus(self.taskJob.id, TaskStatus.SUCCESS)
                    UrlDao.updateUrlStatusListByTaskJobHistoryId(self.taskJobHistoryId, status=UrlStatus.STOP,
                                                                 desc="no db")
            return
        sqlArray=[]
        if data==None or len(data)==0:
            logging.warning('insert data not exist,please retry crawler or check template or check error')
            if llen(ConfigUtils.getRedisPorperties(KEYMAP.MAIN_SPIDER_REDIS_KEY)) == 0:
                if self.taskJob.status != TaskStatus.SUCCESS:
                    TaskJobDao.updateTaskJobStatus(self.taskJob.id, TaskStatus.SUCCESS)
                    UrlDao.updateUrlStatusListByTaskJobHistoryId(self.taskJobHistoryId, status=UrlStatus.STOP,
                                                                 desc="no data")
            return
        logging.info('----pipelines insert data-----%s' % str(data))
        for d in data:
            d["task_job_url"]=url
            if self.dataParentId!=None:
                d["parent_id"]=self.dataParentId
            d["id"]=str(uuid.uuid1())
            if self.dbclient.db_type == 'kafka':
                d['TemplateName'] = jobTemplate.name
                d['UrlStatus'] = 0
                d['Timestamps'] = int(time.time())
            if self.dbclient.db_type == 'hdfs' or self.dbclient.db_type == 'mongodb':
                sqlArray.append(db.insert(jobTemplate.id,tableName, d, paramMap))
            else:
                sqlArray.append(db.insert(tableName,d,paramMap))
            if jobTemplateId!=None:
                try:
                    childJobTemplateList = TemplateDao.queryJobTemplateListByParentId(jobTemplateId)
                    self.loadNext(childJobTemplateList, dict(extraData.items() + d.items()))
                except Exception, e:
                    logging.error(e.message)
                    # print e
        # sqls=";".join(sqlArray)
        try:
            db.execute(sqlArray)
        except Exception, e:
            print e.message
            if not self.dbclient.isTableExist(jobTemplate.tableName):
                self.dbclient.createTable(jobTemplate.id, jobTemplate.tableName, jobTemplateFieldList)
                db.execute(sqlArray)

    def loadNext(self, childJobTemplateList, item):
        if childJobTemplateList == None or len(childJobTemplateList) == 0:
            # pcInfo = Pcinfo()
            # pidList = pcInfo.getPidListByProcessName(ConfigUtils.getRedisPorperties(KEYMAP.PROCESS_SPIDER_NAME))
            # if pidList and len(pidList):
            #     RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.PROCESS_SPIDER_STATUS) + "_" + os.getpid(), 0)
            #     for pid in pidList:
            #         RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.PROCESS_SPIDER_STATUS) + "_" + pid, 0)
            # else:
            if llen(ConfigUtils.getRedisPorperties(KEYMAP.MAIN_SPIDER_REDIS_KEY)) == 0:
                if self.taskJob.status != TaskStatus.SUCCESS:
                    TaskJobDao.updateTaskJobStatus(self.taskJob.id, TaskStatus.SUCCESS)
                    UrlDao.updateUrlStatusListByTaskJobHistoryId(self.taskJobHistoryId, status=UrlStatus.STOP,
                                                                 desc="The task is over and no longer crawls on this URL")
            return
        for jobTemplate in childJobTemplateList:
            parentId=str(item.get("id"))
            taskJobParam=TaskJobParam(paramNameEn="dataParentId",paramValue=parentId)
            taskJobParamList=[]
            taskJobParamList.append(taskJobParam)
            taskJobParamList.extend(self.taskJobParamList)
            CrawlerService.parseUrlAndInsertRedis(taskJob=self.taskJob,
                                                  paramMap=item, taskJobParam=taskJobParamList,
                                                  taskJobHistory=TaskJobHistory(id=self.taskJobHistoryId),
                                                  jobTemplate=jobTemplate)

    def _handle_error(self, failue, item, spider):
        logging.error('handle_error:%s' % failue)
        # print failue
#
# if __name__=="__main__":
#
#     jobTemplateParamList = TemplateDao.queryJobTemplateParamByJobTemplateIdType("85f33911-2368-11e7-a7d7-e09467f6dff0")
#     paramMap={"pageCount":168,"pageNum":180}
#     print DataBaseSavePipeline().paraseJobTemplateList(jobTemplateParamList,paramMap)