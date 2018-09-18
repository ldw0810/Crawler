#coding=utf-8
#Created by xutao on 2017-04-14.
# coding=utf-8
import json
import re
from string import strip
import logging

import scrapy
from scrapy import Selector

from beans import TaskTable
from beans.TaskTable import TaskJob
from cache.Factory import CacheFactory
from dao import TaskJobDao
from dao import TemplateDao
from engine.items import ScrapBaseItem
from engine.spiders.RedisCallbackSpider import RedisCallbackSpider
from dao.TemplateDao import queryFieldByTaskJobId, queryJobTemplate, querTaskJob, queryJobParam
from utils import ConfigUtils
from utils import RedisUtils
from utils import RequestUtils
from utils.ConfigUtils import KEYMAP


class MainRedisSpider(RedisCallbackSpider):#
    name = ConfigUtils.getSpiderPorperties(KEYMAP.MAIN_SPIDER_NAME)
    custom_settings = ConfigUtils.getItems(KEYMAP.REDIS)
    custom_settings["ITEM_PIPELINES"]= {'engine.pipelines.DataBaseSavePipeline': 300}
    custom_settings["DOWNLOADER_MIDDLEWARES"]={'engine.useragent.RotateUserAgentMiddleware': 1,'engine.middlewares.ProxyMiddleware':2}
    custom_settings=dict(custom_settings.items()+ConfigUtils.getItems(KEYMAP.MYSQL).items())
    redis_key = ConfigUtils.getRedisPorperties(KEYMAP.MAIN_SPIDER_REDIS_KEY)
    id=""
    # start_urls=["https://www.baidu.com"]
    def beforeStartUrl(self,dataDict):
        if(dataDict==None):
            return dataDict
        try:
            self.taskJob = RequestUtils.parseResToClass(TaskJob, dataDict)
        except Exception,e:
            logging.error("TemplateRedisSpider[beforeStartUrl:error]:%s"%(e));
            return None
        self.params=dataDict
        id=dataDict.get("id")
        if id==None :
            return
        status = RedisUtils.hgetUrlRedisStatus(RedisUtils.prefix+id)
        # if status!=None and str(status)!=str(TaskTable.TaskStatus.RUNNING):
        #     return None;
        url= dataDict["url"] if dataDict.has_key("url") else "http://www.baidu.com"
        self.url=url
        CacheFactory.cache("job_template_url",id,self.params)
        return url;
    def delItems(self,jobTemplateFieldList,hnode,items):
        item = {}
        for jobTemplateField in jobTemplateFieldList:
            if jobTemplateField == None:
                continue
            fieldNameEn = jobTemplateField.fieldNameEn
            fieldValue = jobTemplateField.fieldValue
            func = jobTemplateField.func
            if fieldValue == None or fieldValue == "":
                if func != None and func != "":
                    item[fieldNameEn] = strip(eval(func))
                    items.append(item)
                continue
            node = hnode.xpath(fieldValue).extract()
            split = jobTemplateField.split if jobTemplateField.split != None else ""
            value = split.join(node)
            value = value if value != None else ""
            regExp = jobTemplateField.regExp
            if regExp != None and regExp != "":
                pattern = re.compile(regExp);
                tempStr=value
                matches = pattern.search(tempStr)
                if matches != None and len(matches.groups()) > 0 and (func == None or func == ""):
                    value = split.join(matches.groups())
                elif matches!=None and (len(matches.groups()) == 0 and matches != None or (func != None and func != "")):
                    value = matches.group()
                else:
                    value=""
            item[fieldNameEn] = strip(value)
        items.append(item)
    def getScrapBaseItem(self,taskJobId):
        taskJobHistoryId = self.params.get("taskJobHistoryId") or ""
        if CacheFactory.get("task_job",taskJobHistoryId)==None:
            taskJob = querTaskJob(taskJobId)
            scrapBaseItem=ScrapBaseItem()
            jobTemplateFieldList = queryFieldByTaskJobId(taskJobId)
            if jobTemplateFieldList==None or len(jobTemplateFieldList)==0:
                jobTemplateFieldList=TemplateDao.queryJobTemplateFieldByJobTemplateId(taskJob.jobTemplateId)
            jobTemplate = queryJobTemplate(taskJob.jobTemplateId)
            jobTemplateParamList = queryJobParam(taskJobId)
            taskJobParamList = TaskJobDao.queryTaskJobParam(taskJobId)
            scrapBaseItem["jobTemplateFieldList"] = jobTemplateFieldList
            scrapBaseItem["jobTemplate"] = jobTemplate
            scrapBaseItem["taskJobId"] = taskJobId
            scrapBaseItem["taskJob"] = taskJob
            setattr(taskJob,"taskJobHistoryId",taskJobHistoryId)
            scrapBaseItem["jobTemplateParamList"] = jobTemplateParamList
            scrapBaseItem["taskJobParamList"] = taskJobParamList
            CacheFactory.cache("task_job",taskJobHistoryId,scrapBaseItem)
            taskJobHistory = None
            if taskJobHistoryId != None and taskJobHistoryId != "" and CacheFactory.get("task_job_history",
                                                                                        taskJobHistoryId) == None:
                taskJobHistory = TaskJobDao.loadTaskJobHistoryById(taskJobHistoryId)
                CacheFactory.cache("task_job_history", taskJobHistoryId, taskJobHistory)
            taskJobHistory = CacheFactory.get("task_job_history", taskJobHistoryId)
            scrapBaseItem["taskJobHistroy"] = taskJobHistory
        return CacheFactory.get("task_job",taskJobHistoryId) or ScrapBaseItem()
    def parse(self, response):
        taskJobId = self.params["id"]
        scrapBaseItem= self.getScrapBaseItem(taskJobId)
        taskJob=scrapBaseItem.get("taskJob")
        jobTemplateParamList=scrapBaseItem.get("jobTemplateParamList")
        jobTemplateFieldList=scrapBaseItem.get("jobTemplateFieldList")
        jobTemplate=scrapBaseItem.get("jobTemplate")
        if jobTemplate == None:
            return;
        hxs = Selector(response)
        scrapBaseItem["data"] = []
        globalParam={};
        if jobTemplateParamList and len(jobTemplateParamList)>0:
            for jobTemplateParam in jobTemplateParamList:
                if jobTemplateParam.type=="1":
                    paramName=jobTemplateParam.paramNameEn
                    paramValue=jobTemplateParam.paramValue;
                    value=hxs.xpath(paramValue)
                    globalParam["global_"+paramName]=value
        scrapBaseItem["globalParamsValues"]=globalParam
        rootPath=jobTemplate.rootPath
        if rootPath!=None and rootPath!="":
            hxs=hxs.xpath(rootPath)
        if jobTemplateFieldList==None:
            return scrapBaseItem
        if hxs!=None or len(hxs)>0:
            items=[]
            if type(hxs)==Selector:
                self.delItems(jobTemplateFieldList, hxs, items)
            else:
                for hnode in hxs:
                    self.delItems(jobTemplateFieldList,hnode,items)
            scrapBaseItem["data"]=items
        self.log('A response from %s just arrived!' % response.url)
        return scrapBaseItem

class AssistRedisSpider(MainRedisSpider):
    name=ConfigUtils.getSpiderPorperties(KEYMAP.ASSIST_SPIDER_NAME)
    redis_key = ConfigUtils.getRedisPorperties(KEYMAP.ASSIST_SPIDER_REDIS_KEY)
    pass

if __name__=="__main__":
    textHtml=u"""
                              出版社：\n
                    中国青年出版社

ISBN：9787500601593
版次：3
商品编码：10162330
包装：平装
开本：32开
出版时间：2005-07-01
用纸：胶版纸
页数：594
正文语种：中文
                        """
    pattern = re.compile(u'出版社：([\s]*[^\s]*)');
    # print textHtml
    matches = pattern.search(textHtml.encode("utf-8"))
    print matches
    if matches:
        print matches.groups()
        print matches.group()
