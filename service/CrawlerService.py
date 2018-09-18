# coding=utf-8
# Created by xutao on 2017-04-14.

import logging

from scrapy.crawler import CrawlerRunner
from scrapy.utils.log import configure_logging
from scrapy.utils.project import get_project_settings
from sqlalchemy import text
from twisted.internet import reactor

from beans.TaskTable import TaskJob, TaskStatus, TaskJobHistoryType, TaskType
from beans.TemplateTable import JobTemplateParam, JobTemplate
from beans.UrlTable import UrlClazz
from dao import LoggerDao
from dao import TaskJobDao
from dao import TemplateDao
from dao import UrlDao
from dao.BaseDao import query
from engine.spiders.SpidersList import MainRedisSpider
from utils import ClassCopy
from utils import ConfigUtils
from utils import RedisUtils
from utils import RenderUtils
from utils.ConfigUtils import KEYMAP
from utils.DBClient import DbClient
from utils.JsonUtils import stringify
from utils.RedisUtils import BloomFilter
from utils.HashFilter import YHash
from utils.RedisUtils import lpush
import urllib
import urllib2

bloomfilter = BloomFilter()

NodeListStr = ConfigUtils.getRedisPorperties(KEYMAP.DISTRIBUTED_SPIDER_NODE_LIST)
NodeList = NodeListStr.split(',')
hashConsistency = YHash(NodeList, int(ConfigUtils.getRedisPorperties(KEYMAP.VIRTUAL_NODE)))
switch = ConfigUtils.getRedisPorperties(KEYMAP.DISTRIBUTED_SPIDER_SWITCH)
hashswitch = switch == str(True)
tempList = []
nodePool = []
mainId = []


def paraseJobTemplateList(jobTemplateParamList, paramMap, loopFlag=False):
    paramList = []
    length = len(jobTemplateParamList)
    newJobTemplateParamList = []
    if jobTemplateParamList != None and length > 0:
        for i in range(length):
            jobTemplateParam = jobTemplateParamList[i]
            paramType = jobTemplateParam.type;
            paramValue = jobTemplateParam.paramValue;
            if paramType == "1":
                str = eval(paramValue)
                for key in str:
                    newJobTemplateParamList.append(JobTemplateParam(paramNameEn=key, paramValue=str.get(key)))
            else:
                # if paramValue!=None and "," in paramValue:
                #     paramValueList=paramValue.split(",");
                #     for param in paramValueList:
                #         newJobTemplateParamList.append(JobTemplateParam(paramNameEn=jobTemplateParam.paramNameEn, paramValue=param))
                # else:
                newJobTemplateParamList.append(jobTemplateParam)
                continue
        for i in range(len(newJobTemplateParamList)):
            jobTemplateParam = newJobTemplateParamList[i]
            if len(paramList) > 0:
                paramLength = len(paramList)
                for j in range(paramLength):
                    param = paramList[j]
                    renderField(jobTemplateParam, paramMap, paramList, param, False, loopFlag)
            else:
                renderField(jobTemplateParam, paramMap, paramList, {}, True, loopFlag)
    return paramList


def renderField(taskJobParam, paramMap, paramList, param, tempFlag, loopFlag=False):
    if taskJobParam == None:
        return
    paramNameEn = taskJobParam.paramNameEn
    paramtype = taskJobParam.type
    paramValue = taskJobParam.paramValue or ""
    # if paramtype == "1":
    #     str = eval(paramValue)
    #     paramMap = dict(paramMap.items() + str.items())
    # else:
    paramMap[paramNameEn] = paramValue
    nextParamValue = taskJobParam.nextParamValue
    paramCondition = taskJobParam.paramCondition
    paramValue = RenderUtils.render(paramValue, paramMap, paramValue)

    if RenderUtils.match(paramValue):
        paramValue = eval(paramValue)
    if param.has_key(paramNameEn):
        return

    # if paramtype=="1":
    #     str = eval(paramValue)
    #     param = dict(param.items() + str.items())
    # else:

    if paramValue != None and "," in paramValue:
        paramValueList = paramValue.split(",");
        for p in paramValueList:
            paramMap = {paramNameEn: p}
            paramList.append(dict(param.items() + paramMap.items()))
        return
    param[paramNameEn] = paramValue
    if tempFlag:
        paramList.append(param)
    condition = None
    if paramCondition != None and paramCondition != "":
        condition = RenderUtils.render(paramCondition, paramMap)
    if condition != None:
        try:
            flag = eval(condition)
        except Exception, e:
            flag = False
            raise Exception('condition(%s,%s),error' % (condition, str(e)))
    tempCondition = []
    tempCondition.append(condition)
    while paramCondition != None and paramCondition != "" and flag and not loopFlag:
        nextParamValueStr = eval(RenderUtils.render(nextParamValue, paramMap, paramValue))
        paramList.append(dict(param.items() + {paramNameEn: nextParamValueStr}.items()))
        paramMap[paramNameEn] = nextParamValueStr
        condition = RenderUtils.render(paramCondition, paramMap)
        if condition not in tempCondition:
            flag = eval(condition)
            tempCondition.append(condition)
        else:
            break


# 废弃     线程中不能启动scrapy
def startEnterRedisSpider():
    configure_logging({'LOG_FORMAT': '%(levelname)s: %(message)s'})
    runner = CrawlerRunner(get_project_settings())
    d = runner.crawl(MainRedisSpider)
    d.addBoth(lambda _: reactor.stop())
    reactor.run()


def saveUrlListStatus(urlListStatus):
    if urlListStatus:
        # RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.URL_LIST_SPIDER_REDIS_KEY) + "_" + urlListStatus.taskJobId,
        #                  json.dumps(urlListStatus))
        UrlDao.addUrl(urlListStatus)


# scrapyCrawler(TaskJob(url="https://book.jd.com/booksort.html"))
def parseUrlAndInsertRedis(taskJob, paramMap={}, taskJobParam=None, taskJobHistory=None, jobTemplate=None):
    if TaskType.DEPTH == str(taskJob.type):
        if bloomfilter_check(taskJob.id, taskJob.url):
            RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.DEPTH_SPIDER_REDIS_KEY), taskJobHistory.id)
            RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.DEPTH_SPIDER_REDIS_KEY) + "_" + taskJobHistory.id,
                             stringify(taskJob))
    else:
        url = taskJob.url
        taskJobParamList = TaskJobDao.queryTaskJobParam(taskJob.id)
        if taskJobParam != None:
            if isinstance(taskJobParam, list):
                taskJobParamList.extend(taskJobParam)
            else:
                taskJobParamList.append(taskJobParam)
        jobTemplateParamList = TemplateDao.queryJobTemplateParamByJobTemplateId(jobTemplate.id)
        if jobTemplateParamList != None and len(jobTemplateParamList) > 0:
            taskJobParamList.extend(jobTemplateParamList)
        if taskJobHistory != None:
            jobTemplateParamTaskJob = JobTemplateParam(paramNameEn="task_job_id_sequence",
                                                       paramValue=str(taskJobHistory.id))
            jobTemplateParamList.append(jobTemplateParamTaskJob)
        if taskJobParamList == None or len(taskJobParamList) <= 0:
            if str(taskJob.type) == TaskType.BATCH:
                url = jobTemplate.url
            renderUrl = RenderUtils.render(url, paramMap)

            # if bloomfilter_check(taskJob.id, renderUrl):
            newJobTemplate = ClassCopy.copyToNewInstances(jobTemplate, JobTemplate)
            taskJobHistoryId = taskJobHistory.id
            urlListStatus = UrlClazz(url=jobTemplate.url, parentUrl=paramMap.get("task_job_url"),
                                     jobTemplateId=jobTemplate.id,
                                     jobTemplateParentId=jobTemplate.parentId, taskJobId=taskJob.id,
                                     taskJobHistoryId=taskJobHistoryId)
            # try:
            #     request = urllib2.Request(
            #         url=url,
            #         headers={
            #             'User-Agent': 'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6'}
            #     )
            #     response = urllib2.urlopen(request)
            #     urldate = response.headers['date']
            # except Exception:
            #     pass
            #     print Exception
            setattr(newJobTemplate, "taskJobId", taskJob.id)
            setattr(newJobTemplate, "taskJobHistoryId", taskJobHistoryId)
            setattr(newJobTemplate, "url", renderUrl)
            setattr(newJobTemplate, "extraData", paramMap)
            # setattr(newJobTemplate, "urldate", urldate)
            setattr(newJobTemplate, "urlListStatusId", urlListStatus.id)
            LoggerDao.addTaskJobLogger(taskJob, LoggerDao.LoggerType.URL_TO_REDIS,
                                       jobTemplateId=newJobTemplate.id, taskJobHistoryId=taskJobHistoryId,
                                       content=u"redis_入库", url=renderUrl, status=TaskStatus.RUNNING)
            # if (hashswitch):
            #     tempList.append(stringify(newJobTemplate))
            # else:
            # mainId.append(stringify(newJobTemplate))
            RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.ASSIST_SPIDER_REDIS_KEY), taskJobHistoryId)
            RedisUtils.lpush(
                ConfigUtils.getRedisPorperties(KEYMAP.ASSIST_SPIDER_REDIS_KEY) + "_" + taskJobHistoryId,
                stringify(newJobTemplate))
            RedisUtils.hset(ConfigUtils.getRedisPorperties(KEYMAP.FINISH_SPIDER_REDIS_KEY), newJobTemplate.id,
                            stringify(newJobTemplate))
            saveUrlListStatus(urlListStatus)
        else:
            for data in paraseJobTemplateList(taskJobParamList, paramMap):
                if str(taskJob.type) == TaskType.BATCH:
                    url = jobTemplate.url
                parentId = paramMap.get("dataParentId")
                paramMap = dict(paramMap.items() + data.items())
                renderUrl = RenderUtils.render(url, paramMap)
                # if bloomfilter_check(taskJob.id, renderUrl):
                newJobTemplate = ClassCopy.copyToNewInstances(jobTemplate, JobTemplate)
                taskJobHistoryId = taskJobHistory.id
                urlListStatus = UrlClazz(url=renderUrl, parentUrl=paramMap.get("task_job_url"),
                                         jobTemplateId=jobTemplate.id,
                                         jobTemplateParentId=jobTemplate.parentId, taskJobId=taskJob.id,
                                         taskJobHistoryId=taskJobHistoryId)
                # try:
                #     request = urllib2.Request(
                #         url=url,
                #         headers={
                #             'User-Agent': 'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6'
                #         }
                #     )
                #     response = urllib2.urlopen(request)
                #     urldate = response.headers['date']
                # except Exception:
                #     pass
                #     print Exception
                setattr(newJobTemplate, "taskJobId", taskJob.id)
                setattr(newJobTemplate, "taskJobHistoryId", taskJobHistoryId)
                setattr(newJobTemplate, "url", renderUrl)
                setattr(newJobTemplate, "dataParentId", parentId)
                setattr(newJobTemplate, "extraData", paramMap)
                # setattr(newJobTemplate, "urldate", urldate)
                setattr(newJobTemplate, "urlListStatusId", urlListStatus.id)
                LoggerDao.addTaskJobLogger(taskJob, LoggerDao.LoggerType.URL_TO_REDIS,
                                           jobTemplateId=newJobTemplate.id, taskJobHistoryId=taskJobHistoryId,
                                           content=u"redis_入库_多参数", url=renderUrl, status=TaskStatus.RUNNING)
                # if (hashswitch):
                #     tempList.append(newJobTemplate)
                # else:
                RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.ASSIST_SPIDER_REDIS_KEY),
                                 taskJobHistoryId)
                RedisUtils.lpush(
                    ConfigUtils.getRedisPorperties(KEYMAP.ASSIST_SPIDER_REDIS_KEY) + "_" + taskJobHistoryId,
                    stringify(newJobTemplate))
                # mainId.append(stringify(newJobTemplate))
                RedisUtils.hset(ConfigUtils.getRedisPorperties(KEYMAP.FINISH_SPIDER_REDIS_KEY),
                                newJobTemplate.id, stringify(newJobTemplate))
                saveUrlListStatus(urlListStatus)


# def startCrawlerByTaskJobId(jobId,taskJobParam=None){
# }
# 启动爬虫
def startCrawlerByTaskJobId(jobId, taskJobParam=None):
    logging.info('------startCrawlerByTaskJobId-------%s' % jobId)
    taskJobHistory = TaskJobDao.addTaskJobHistroy(jobId, TaskJobHistoryType.SINGLE)
    taskJob = query(TaskJob, text('id="' + str(jobId) + '"'), type=0)
    TaskJobDao.updateTaskJobStatus(jobId, TaskStatus.RUNNING)
    # tableName = jobTemplate.tableName
    jobTemplateId = None
    dbClient = DbClient()
    LoggerDao.addTaskJobLogger(taskJob, LoggerDao.LoggerType.START, taskJobHistoryId=taskJobHistory.id,
                               status=TaskStatus.RUNNING, content=u"任务启动")
    try:
        if TaskType.SINGLE == str(taskJob.type):
            jobTemplate = TemplateDao.queryJobTemplate(taskJob.jobTemplateId)
            if jobTemplate == None:
                TaskJobDao.updateTaskJobStatus(jobId, TaskStatus.FAIL)
                LoggerDao.addTaskJobLogger(taskJob, LoggerDao.LoggerType.START, jobTemplateId=jobTemplateId,
                                           taskJobHistoryId=taskJobHistory.id, content=u"no jobTemplate")
                logging.error("no jobTemplate")
                return
            jobTemplateId = jobTemplate.id
            taskJobParam = crawlerbyKeyWord(taskJob, jobTemplate.id)
            jobTemplateFieldList = TemplateDao.queryJobTemplateFieldByJobTemplateId(jobTemplate.id)
            dbClient.getConnection(taskJob.databaseId or jobTemplate.databaseId)
            if not dbClient.isTableExist(jobTemplate.tableName):
                dbClient.createTable(jobTemplate.id, jobTemplate.tableName, jobTemplateFieldList)
            setattr(jobTemplate, "url", taskJob.url)
            setattr(jobTemplate, "tableName", taskJob.tableName)
            LoggerDao.addTaskJobLogger(taskJob, LoggerDao.LoggerType.START,
                                       jobTemplateId=jobTemplate.id, taskJobHistoryId=taskJobHistory.id,
                                       status=TaskStatus.RUNNING, content=u"定向任务任务启动")
            parseUrlAndInsertRedis(taskJob, taskJobParam=taskJobParam, taskJobHistory=taskJobHistory,
                                   jobTemplate=jobTemplate)
        elif TaskType.BATCH == str(taskJob.type):
            jobTemplateList = TemplateDao.loadTemplateByTaskJobId({"taskJobId": taskJob.id, "action": "1"})
            if jobTemplateList.get("jobTemplateList") != None and len(jobTemplateList.get("jobTemplateList")) > 0:
                for jobTemplate in jobTemplateList.get("jobTemplateList"):
                    jobTemplateId = jobTemplate.id
                    taskJobParam = crawlerbyKeyWord(taskJob, jobTemplate.id)
                    jobTemplateFieldList = TemplateDao.queryJobTemplateFieldByJobTemplateId(jobTemplate.id)
                    LoggerDao.addTaskJobLogger(taskJob, LoggerDao.LoggerType.START,
                                               jobTemplateId=jobTemplate.id, taskJobHistoryId=taskJobHistory.id,
                                               status=TaskStatus.RUNNING, content=u"批量任务启动")
                    databaseId = jobTemplate.databaseId if jobTemplate.databaseId != "-1" and jobTemplate.databaseId != None else taskJob.databaseId
                    dbClient.getConnection(databaseId)
                    if dbClient == None:
                        TaskJobDao.updateTaskJobStatus(jobId, TaskStatus.FAIL)
                        LoggerDao.addTaskJobLogger(taskJob, LoggerDao.LoggerType.START, jobTemplateId=jobTemplateId,
                                                   taskJobHistoryId=taskJobHistory.id, content=u"no dbClient")
                        logging.error("no dbClient")
                        return
                    if not dbClient.isTableExist(jobTemplate.tableName):
                        dbClient.createTable(jobTemplate.id, jobTemplate.tableName, jobTemplateFieldList)
                    parseUrlAndInsertRedis(taskJob, taskJobParam=taskJobParam, taskJobHistory=taskJobHistory,
                                           jobTemplate=jobTemplate)
            else:
                TaskJobDao.updateTaskJobStatus(jobId, TaskStatus.FAIL)
                LoggerDao.addTaskJobLogger(taskJob, LoggerDao.LoggerType.START, jobTemplateId=jobTemplateId,
                                           taskJobHistoryId=taskJobHistory.id, content=u"no jobTemplate")
                logging.error("no jobTemplate")
        elif TaskType.DEPTH == str(taskJob.type):
            parseUrlAndInsertRedis(taskJob, taskJobParam=taskJobParam, taskJobHistory=taskJobHistory)

            # print mainId
            # if tempList:
            #     for temp in tempList:
            #         tempNode = hashConsistency.get_node(stringify(temp))
            #         nodePool.append(tempNode)
            #         RedisUtils.lpush(tempNode+"_"+ConfigUtils.getRedisPorperties(KEYMAP.ASSIST_SPIDER_REDIS_KEY), taskJobHistory.id)
            #         RedisUtils.lpush(tempNode+"_"+ConfigUtils.getRedisPorperties(KEYMAP.ASSIST_SPIDER_REDIS_KEY) + "_" + taskJobHistory.id,stringify(temp))
            #         RedisUtils.hset(ConfigUtils.getRedisPorperties(KEYMAP.FINISH_SPIDER_REDIS_KEY), temp.id, stringify(temp))
    except Exception, e:
        TaskJobDao.updateTaskJobStatus(jobId, TaskStatus.FAIL)
        LoggerDao.addTaskJobLogger(taskJob, LoggerDao.LoggerType.START, jobTemplateId=jobTemplateId,
                                   taskJobHistoryId=taskJobHistory.id, content=u"解析异常" + str(e))
        logging.error(repr(Exception))


def crawlerbyKeyWord(taskjob, jobtempid):
    if taskjob.keyWord:
        # jobTemplateParamList = []
        jobTemplateParam = JobTemplateParam(paramNameEn="key", paramValue=taskjob.keyWord, jobTemplateId=jobtempid)
        return jobTemplateParam

    else:
        return None


def bloomfilter_check(id, url):
    """
    bloomfilter排重检查
    :param id: taskJobId
    :param url: 待爬取的url
    :return: 
    """
    if not url:
        return False
    url = url.lower()
    flag = bloomfilter.isContains(id, url)
    if flag:
        return False
    else:
        bloomfilter.insert(id, url)
        return True


if __name__ == "__main__":
    # lpush("1243", stringify(TaskJob()))
    b = True
    print not b
