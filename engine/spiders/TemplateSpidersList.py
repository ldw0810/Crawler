# coding=utf-8
# Created by xutao on 2017-04-14.
# coding=utf-8
import json
import logging
import re
from string import strip

from scrapy import Selector
from scrapy.selector import SelectorList

from beans.TemplateTable import JobTemplate, DataType
from beans.UrlTable import UrlStatus
from cache.Factory import CacheFactory
from dao import LoggerDao
from dao import TaskJobDao
from dao import TemplateDao
from dao import UrlDao
from engine.items import TemplateItem
from engine.spiders.RedisCallbackSpider import RedisCallbackSpider
from utils import ConfigUtils
from utils import ParseUtils
from utils import RedisUtils
from utils import RenderUtils
from utils import RequestUtils
from utils.ConfigUtils import KEYMAP
from utils import AdUtil

class TemplateRedisSpider(RedisCallbackSpider):  # RedisCallbackSpider
    name = ConfigUtils.getSpiderPorperties(KEYMAP.TEMPLATE_SPIDER_NAME)
    custom_settings = ConfigUtils.getItems(KEYMAP.REDIS)
    custom_settings["ITEM_PIPELINES"] = {'engine.pipelines_template.DataBaseSavePipeline': 300}
    custom_settings["DOWNLOADER_MIDDLEWARES"] = {
        'engine.useragent.RotateUserAgentMiddleware': 1,
        'engine.middlewares.ProxyMiddleware': 2,
        'engine.middlewares.PhontomJsMiddleware': 4,
        'engine.middlewares.ChromeMiddleware': 6,
        'engine.middlewares.PostMiddleware': 5,
        'engine.middlewares.CookieMiddleware': 3  # cookie配置的顺序待调整
    }
    # PostMiddleware
    custom_settings = dict(custom_settings.items() + ConfigUtils.getItems(KEYMAP.MYSQL).items())
    redis_key = ConfigUtils.getRedisPorperties(KEYMAP.TEMPLATE_SPIDER_NAME_REDIS_KEY)
    id = ""

    # def make_requests_from_url(self,url):
    #     # urls = [
    #     #     'http://10.140.8.56/js_fssc/',
    #     #     # "http://www.baidu.com",
    #     #     # 'http://10.140.8.56/js_fssc/wfclient.msg.msgQueryResult.do?cmd=getMessageList'
    #     # ]
    #     # for url in urls:
    #         yield scrapy.Request(url=url, callback=self.parse,dont_filter=True)
    def beforeStartUrl(self, dataDict):
        if (dataDict == None):
            return dataDict
        try:
            self.jobTemplate = RequestUtils.parseResToClass(JobTemplate, dataDict)
            if dataDict.get("dataParentId") != None:
                setattr(self.jobTemplate, "dataParentId", dataDict.get("dataParentId"))
        except Exception, e:
            logging.error("TemplateRedisSpider[beforeStartUrl:error]:%s" % (e));
            return None
        self.params = dataDict
        id = dataDict.get("id")
        if id == None:
            return
        status = RedisUtils.hgetUrlRedisStatus(RedisUtils.prefix + id)
        url = dataDict["url"] if dataDict.has_key("url") else "http://www.baidu.com"
        self.url = url
        id = self.jobTemplate.id or ""
        dataParentId = self.jobTemplate.dataParentId if hasattr(self.jobTemplate, "dataParentId") else ""
        taskJobHistoryId = self.jobTemplate.taskJobHistoryId if hasattr(self.jobTemplate, "taskJobHistoryId") else ""
        taskJobHistory = TaskJobDao.loadTaskJobHistoryById(taskJobHistoryId)
        if taskJobHistoryId is not None:
            taskJobId = taskJobHistory.taskJobId
            self.taskJob = TaskJobDao.loadTaskById(taskJobId)
        key = self.getKey(id, dataParentId, taskJobHistoryId)
        CacheFactory.cache("job_template_url", key, self.jobTemplate)
        jobTemplateList = CacheFactory.get("job_template_by_url", url)
        if jobTemplateList == None:
            jobTemplateList = []
        jobTemplateList.append(self.jobTemplate)
        CacheFactory.cache("job_template_by_url", url, jobTemplateList)
        return url

    def getKey(self, id, dataParentId, taskJobHistoryId):
        return "%s_%s_%s" % (id, dataParentId, taskJobHistoryId)

    def getFieldValue(self, data, fieldValue, typeStr,extraData=None):
        node = None
        if (RenderUtils.match(fieldValue)):
            return RenderUtils.render(fieldValue, extraData);
        if int(typeStr) == int(DataType.XPATH):
            if type(data) != Selector:
                data = Selector(data)
            node = ParseUtils.getXpathData(data, fieldValue.decode('utf-8'))
        elif int(typeStr) == int(DataType.JSON):
            node = ParseUtils.getJSONData(data, fieldValue)
            if not (isinstance(node, list)):
                temp = []
                temp.append(str(node))
                node = temp
        elif int(typeStr) == int(DataType.STR):
            node = data.decode('utf-8')
        return node

    def getRootPath(self, data, fieldvalue, typeStr, encodeType=None):
        node = None
        typeStrArray = typeStr.split("-", 1)
        typeStr = typeStrArray[0]
        if fieldvalue != None and fieldvalue != "":
            fieldvalueArray = fieldvalue.split("&", 1)
            fieldvalue = fieldvalueArray[0]
        if typeStr == DataType.XPATH:
            if isinstance(data, (str, unicode)):
                node = Selector(text=data.encode('utf-8'))
            else:
                node = Selector(data)
            if fieldvalue != None and fieldvalue != "":
                node = ParseUtils.getRootXPath(node, fieldvalue)
        elif typeStr == DataType.JSON:
            if encodeType is not None and encodeType != '' and encodeType != 'utf-8':
                node = json.loads(data.body.decode(encodeType).encode('utf-8'))
            else:
                node = json.loads(data.body)

            if fieldvalue != None and fieldvalue != "":
                node = ParseUtils.getJSONData(node, fieldvalue)
        elif typeStr == DataType.STR:
            node = data.body
            if fieldvalue != None and fieldvalue != "":
                pattern = re.compile(fieldvalue);
                tempStr = data.body
                node = pattern.findall(tempStr)
        if len(typeStrArray) > 1:
            node = self.getRootPath(node, fieldvalueArray[1], typeStrArray[1])
        return node

    def delItems(self, jobTemplateFieldList, hnode, items, type, jobTemplate=None):
        item = {}
        jobTemplate = jobTemplate if jobTemplate != None else self.jobTemplate;
        extraData = jobTemplate.extraData
        for jobTemplateField in jobTemplateFieldList:
            if jobTemplateField == None:
                continue
            fieldNameEn = str(jobTemplateField.fieldNameEn)
            fieldValue = str(jobTemplateField.fieldValue)
            func = jobTemplateField.func
            if fieldValue == None or fieldValue == "":
                if func != None and func != "":
                    item[fieldNameEn] = str(strip(eval(func)))
                    item[fieldNameEn] = strip(eval(func))
                    funcValue = eval(func)
                    if type(funcValue) == list:
                        funcValue = "".join(",")
                    item[fieldNameEn] = strip(str(funcValue))
                    items.append(item)
                continue
            # node = hnode.xpath(fieldValue).extract()
            node = self.getFieldValue(hnode, fieldValue, type,extraData)  # hnode.xpath(fieldValue).extract()
            split = jobTemplateField.split if jobTemplateField.split != None else ""
            value = split.join(node)
            value = value if value != None else ""
            regExp = jobTemplateField.regExp
            if regExp != None and regExp != "":
                pattern = re.compile(regExp);
                tempStr = value
                matches = pattern.search(tempStr)
                if matches != None and len(matches.groups()) > 0 and (func == None or func == ""):
                    value = split.join(matches.groups())
                elif matches != None and (
                                    len(matches.groups()) == 0 and matches != None or (func != None and func != "")):
                    value = matches.group()
                else:
                    value = ""
            if func != None and func != "":
                value = func.replace("{value}", value)
                if extraData != None:
                    value = RenderUtils.render(value, extraData)
                value = eval(value)
            if not isinstance(value, list):
                item[fieldNameEn] = str(strip(value))
        if len(item.keys()) > 0:
            items.append(item)

    def getItem(self, jobTemplateId, taskJobHistoryId=None):
        taskJobHistoryId = taskJobHistoryId or self.params.get("taskJobHistoryId") or ""
        taskJobHistory = None
        if taskJobHistoryId != None and taskJobHistoryId != "" and CacheFactory.get("task_job_history",
                                                                                    taskJobHistoryId) == None:
            taskJobHistory = TaskJobDao.loadTaskJobHistoryById(taskJobHistoryId)
            CacheFactory.cache("task_job_history", taskJobHistoryId, taskJobHistory)
        else:
            taskJobHistory = CacheFactory.get("task_job_history", taskJobHistoryId)
        taskJobId = taskJobHistory.taskJobId
        taskJob = None
        if taskJobId != None and taskJobId != "" and CacheFactory.get("task_job", taskJobId) == None:
            taskJob = TaskJobDao.loadTaskById(taskJobId)
            CacheFactory.cache("task_job", taskJobId, taskJob)
        else:
            taskJob = CacheFactory.get("task_job", taskJobId)
        jobTemplate = None
        # logging.info('Spider getItem with jobid:%s',taskJob.id)
        if jobTemplateId != None and jobTemplateId != "" and CacheFactory.get("job_template_single",
                                                                              jobTemplateId) == None:
            jobTemplate = TemplateDao.queryJobTemplate(jobTemplateId)
            CacheFactory.cache("job_template_single", jobTemplateId, jobTemplate)
        if CacheFactory.get("job_template", jobTemplateId) == None:
            templateItem = TemplateItem()
            jobTemplateFieldList = TemplateDao.queryJobTemplateFieldByJobTemplateId(jobTemplateId)  # (jobTemplateId)
            jobTemplate = TemplateDao.queryJobTemplate(jobTemplateId)
            jobTemplateParamList = TemplateDao.queryJobTemplateParamByJobTemplateId(jobTemplateId)
            templateItem["jobTemplateFieldList"] = jobTemplateFieldList
            templateItem["jobTemplate"] = jobTemplate
            templateItem["jobTemplateParamList"] = jobTemplateParamList
            taskJobHistory = CacheFactory.get("task_job_history", taskJobHistoryId)
            templateItem["taskJobHistroy"] = taskJobHistory
            taskJobId = taskJobHistory.taskJobId
            templateItem["taskJob"] = CacheFactory.get("task_job", taskJobId)
            CacheFactory.cache("job_template", jobTemplateId, templateItem)
        templateItem = CacheFactory.get("job_template", jobTemplateId) or TemplateItem()
        return templateItem

    def baidu(self, items, content, fieldNameEn):
        regExp = r'surl([\s\S]*?)plans_include'
        pattern = re.compile(regExp);
        matches = pattern.findall(content)
        if matches:
            for m in matches:
                item = {}
                aregExp = r'ambiguity_sname":"(.*?)"'
                apattern = re.compile(aregExp);
                amatches = apattern.findall(m)
                for a in amatches:
                    name = a.decode('unicode_escape')
                    if ((str(a) == "亚洲") | (str(a) == "中国") | (str(a) == "四川") | (str(a) == "成都")):
                        continue
                    item[u'name'] = strip(name)
                bregExp = r'avg_remark_score":"(.*?)"'
                bpattern = re.compile(bregExp);
                score = bpattern.findall(m)
                item[u'score'] = strip((score[0] if len(score) > 0 else "0") + "分")
                cregExp = r'remark_count":"(.*?)"'
                cpattern = re.compile(cregExp);
                comment = cpattern.findall(m)
                item[u'comment'] = strip((comment[-1] if len(score) > 0 else "0") + "条评论")
                items.append(item)
        return items

    def parse(self, response):
        id = response.meta["id"] or ""
        url = response.url
        dataParentId = response.meta["dataParentId"] or ""
        taskJobHistoryId = response.meta["taskJobHistoryId"] or ""
        urlListStatusId = response.meta["urlListStatusId"]
        if urlListStatusId:
            UrlDao.updateUrlStatus(urlListStatusId, UrlStatus.SUCCESS)
        jobTemplate = CacheFactory.get("job_template_url", self.getKey(id, dataParentId, taskJobHistoryId))
        if jobTemplate == None:
            return None
        taskJobId = jobTemplate.id
        templateItem = self.getItem(taskJobId, taskJobHistoryId)
        newTemplateItem = TemplateItem()
        jobTemplateParamList = templateItem.get("jobTemplateParamList")
        newTemplateItem["jobTemplateParamList"] = jobTemplateParamList
        jobTemplateFieldList = templateItem.get("jobTemplateFieldList")
        newTemplateItem["jobTemplateFieldList"] = jobTemplateFieldList
        taskJobHistory = CacheFactory.get("task_job_history", taskJobHistoryId)
        if taskJobHistory == None:
            taskJobHistory = TaskJobDao.loadTaskJobHistoryById(taskJobHistoryId)
        taskJobId = taskJobHistory.taskJobId
        taskJob = CacheFactory.get("task_job", taskJobId)
        if taskJob == None:
            taskJob = TaskJobDao.loadTaskById(taskJobId)
        newTemplateItem["taskJobHistroy"] = taskJobHistory
        newTemplateItem["taskJob"] = taskJob
        newTemplateItem["url"] = url
        LoggerDao.addTaskJobLogger(taskJob, LoggerDao.LoggerType.CRAWLER_URL_RESPONSE,
                                   jobTemplateId=jobTemplate.id, taskJobHistoryId=taskJobHistoryId,
                                   content=u"任务爬取完成", url=url)
        # setattr(jobTemplate, "dataParentId", self.params.get("dataParentId"))
        if taskJobHistoryId != None:
            setattr(jobTemplate, "taskJobHistoryId", taskJobHistoryId)
        newTemplateItem["jobTemplate"] = jobTemplate
        newTemplateItem["data"] = []

        globalParam = {};
        parseType = "1" if jobTemplate.parseType == str(
            0) or jobTemplate.parseType == None or jobTemplate.parseType == '1'else jobTemplate.parseType
        if jobTemplateParamList and len(jobTemplateParamList) > 0:

            for jobTemplateParam in jobTemplateParamList:
                if jobTemplateParam.type == "1":
                    paramName = jobTemplateParam.paramNameEn
                    paramValue = jobTemplateParam.paramValue
                    # value=hxs.xpath(paramValue)
                    value = self.getFieldValue(response, paramValue, parseType)
                    globalParam["global_" + paramName] = value
        newTemplateItem["globalParamsValues"] = globalParam
        rootPath = jobTemplate.rootPath
        # if rootPath!=None and rootPath!="":
        hxs = self.getRootPath(response, rootPath, parseType, jobTemplate.encodeType)
        temp = parseType.split('-')
        parseType = temp[-1]
        if jobTemplateFieldList == None:
            return newTemplateItem
        if hxs != None or len(hxs) > 0:
            items = []
            if type(hxs) == Selector:
                try:
                    self.delItems(jobTemplateFieldList, hxs, items, parseType, jobTemplate)
                except Exception, e:
                    logging.error("parse error：%s" % e)
                newTemplateItem["data"] = items
            else:
                if isinstance(hxs, list) or type(hxs) == list or type(hxs) == SelectorList:
                    for hnode in hxs:
                        self.delItems(jobTemplateFieldList, hnode, items, parseType, jobTemplate)
                        newTemplateItem["data"] = items
                else:
                    self.delItems(jobTemplateFieldList, hxs, items, parseType, jobTemplate)
                    newTemplateItem["data"] = items
        self.log('A response from %s just arrived!' % response.url)
        return newTemplateItem


if __name__ == "__main__":
    # print urllib.urlencode("https%3A//www.readnovel.com/search%3Fkw%3D%25E5%2588%25BA%25E5%25AE%25A2%25E4%25BF%25A1%25E6%259D%25A1")
    textHtml = u"""
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
