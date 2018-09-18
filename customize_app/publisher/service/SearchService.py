#coding=utf-8
#Created by xutao on 2017-05-09.
import urllib

from Settings import KEYMAP
from beans.TaskTable import TaskJobParam
from beans.TemplateTable import JobTemplateParam, JobTemplate
from cache.Factory import CacheFactory
from customize_app.publisher.beans.WebTable import JobStatus
from customize_app.publisher.dao import SearchTaskDao
from dao import TaskJobDao
from dao import TemplateDao
from dao.BaseDao import Session, with_session
from service import CrawlerService
from utils import ClassCopy
from utils import ConfigUtils
from utils import RedisUtils
from utils import RenderUtils
from utils.JsonUtils import stringify


@with_session
def Search(key):
    return ""
@with_session
def paraseJobTemplateList( jobTemplateParamList, paramMap,jobTemplate):
    paramList = []
    length = len(jobTemplateParamList)
    if jobTemplateParamList != None and length > 0:
        for i in range(length):
            jobTemplateParam = jobTemplateParamList[i]
            if len(paramList) > 0:
                paramLength = len(paramList)
                for j in range(paramLength):
                    param = paramList[j]
                    renderField(jobTemplateParam, paramMap, paramList, param, False,jobTemplate)
            else:
                renderField(jobTemplateParam, paramMap, paramList, {}, True,jobTemplate)
    return paramList
@with_session
def renderField(jobTemplateParam,paramMap,paramList,param,tempFlag,jobTemplate=None):
    if jobTemplateParam==None:
        return
    paramNameEn = jobTemplateParam.paramNameEn
    paramValue = jobTemplateParam.paramValue
    paramMap[paramNameEn]=paramValue
    nextParamValue = jobTemplateParam.nextParamValue
    paramCondition = jobTemplateParam.paramCondition
    paramValue=RenderUtils.render(paramValue, paramMap, paramValue)
    if RenderUtils.match(paramValue):
        paramValue=eval(paramValue)
    if jobTemplate!=None and jobTemplate.encodeType!=None and jobTemplate.encodeType!="":
        paramValue=urllib.quote(str(paramValue))
    if param.has_key(paramNameEn):
        return
    param[paramNameEn] = paramValue
    if tempFlag:
        paramList.append(param)
    condition=None
    if paramCondition!=None:
        condition=RenderUtils.render(paramCondition, paramMap)
    if condition!=None:
        flag = eval(condition)
    while paramCondition != None and paramCondition != "" and flag:
        nextParamValueStr = eval(RenderUtils.render(nextParamValue, paramMap, paramValue))
        paramList.append(dict(param.items()+{paramNameEn: nextParamValueStr}.items()))
        paramMap[paramNameEn]=nextParamValueStr
        flag = eval(RenderUtils.render(paramCondition, paramMap))
# scrapyCrawler(TaskJob(url="https://book.jd.com/booksort.html"))
@with_session
def parseUrlAndInsertRedis(jobTemplate,paramMap={},jobParamList=None,taskJobHistory=None):
    url=jobTemplate.url
    jobTemplateId=jobTemplate.id
    taskJobHistoryId=None
    if taskJobHistory!=None:
        taskJobHistoryId=taskJobHistory.id
    jobTemplateParamList = TemplateDao.queryJobTemplateParamByJobTemplateId(jobTemplateId)
    if jobTemplateParamList==None:
        jobTemplateParamList=[]
    if jobTemplate!=None and jobParamList!=None:
        jobTemplateParamList.extend(jobParamList)
    if jobTemplateParamList == None or len(jobTemplateParamList) <= 0:
        renderUrl = RenderUtils.render(url, paramMap)
        newJobTemplate = ClassCopy.copyToNewInstances(jobTemplate,JobTemplate)
        newJobTemplate.url = renderUrl
        setattr(newJobTemplate,"taskJobHistoryId",taskJobHistoryId)
        # RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.TEMPLATE_SPIDER_NAME_REDIS_KEY), taskJobHistoryId)
        # RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.TEMPLATE_SPIDER_NAME_REDIS_KEY)+"_"+taskJobHistoryId, stringify(newJobTemplate))
    else:
        for data in paraseJobTemplateList(jobTemplateParamList, paramMap,jobTemplate):
            renderUrl = RenderUtils.render(url, dict(paramMap.items() + data.items()))
            newJobTemplate = ClassCopy.copyToNewInstances(jobTemplate, JobTemplate)
            newJobTemplate.url = renderUrl
            setattr(newJobTemplate, "taskJobHistoryId", taskJobHistoryId)
            # RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.TEMPLATE_SPIDER_NAME_REDIS_KEY), taskJobHistoryId)
            # RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.TEMPLATE_SPIDER_NAME_REDIS_KEY)+"_"+taskJobHistoryId, stringify(newJobTemplate))
@with_session
def startCrawlerByTaskJobId(taskJobId):
    jobTemplateParamList=[]
    searchTaskJob=SearchTaskDao.loadTaskById(taskJobId)
    jobTemplateParam = JobTemplateParam(paramNameEn="key",paramValue=searchTaskJob.key)
    jobTemplateList=Session.query(JobTemplate).filter(JobTemplate.delFlag==False,JobTemplate.jobTemplateType==searchTaskJob.type).all()
    #添加执行历史记录
    taskJobHistory=TaskJobDao.addTaskJobHistroy(taskJobId)
    taskJobHistoryId=taskJobHistory.id
    jobTemplateParamTaskJob = JobTemplateParam(paramNameEn="task_job_id_sequence", paramValue=taskJobHistory.id)
    jobTemplateParamList.append(jobTemplateParam)
    jobTemplateParamList.append(jobTemplateParamTaskJob)
    # CacheFactory.cache("task_job_param",taskJobHistoryId,jobTemplateParamList)
    # RedisUtils.lpush("task_job_param_"+taskJobHistoryId,jobTemplateParamList)
    SearchTaskDao.updateSearckTask(taskJobId,JobStatus.RUNNING)
    for child in jobTemplateList:
        startCrawlerByTemplateId(child.id,jobTemplateParamList,taskJobHistory)
@with_session
def startCrawlerByTemplateId(templateId,jobTemplateParamList,taskJobHistory):
    jobTemplate=TemplateDao.queryJobTemplate(templateId)
    if jobTemplate==None:
        return
    parseUrlAndInsertRedis(jobTemplate,{},jobTemplateParamList,taskJobHistory)

if __name__=="__main__":
    b=[]
    b.extend(["123","12342123"])
    print b