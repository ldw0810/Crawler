# coding=utf-8
import json
import urllib2
import uuid
from datetime import datetime

import math

import logging
from flask import make_response
from flask import request
from scrapy import spider

from Settings import KEYMAP
from beans import UrlTable
from beans.PcInfoTable import PcWorkStatus
from beans.UrlTable import UrlStatus
from dao import ContentTypeDao
from dao import ProxyDao
from dao import TaskJobDao
from dao import TemplateDao
from dao import TaskTimerDao
from dao import UrlDao
from dao.TaskJobDao import loadTaskById
from dao.TaskJobScheduler import TaskJobScheduler
from dao.BaseDao import Page, Session
from service import CrawlerService
from service import TaskService
from utils import CalcUtils
from utils import ClassCopy
from utils import ConfigUtils
from utils import RedisUtils
from utils import RequestUtils
from utils import ResponseUtils
from web import app
from sqlalchemy import text
from beans.TaskTable import TaskJob, TaskStatus, DbSource, TaskJobTimer, ProxyInfo, ContentType, TaskJobHistoryType, \
    TaskType
from beans.TemplateTable import TaskJobReField, JobTemplate, JobTemplateField, JobTemplateParam, UserLoginBehavior
from dao import BaseDao
from dao import TemplateDao
from service.CrawlerService import startCrawlerByTaskJobId
from utils import DataBaseUtils
from utils.DataBaseUtils import exportJobTemplate
from utils.JsonUtils import parseJsonToClass, stringify, parseClassToDict
from utils.RequestUtils import loadParams, parseFile, parseResToClass
from utils.ResponseUtils import parseResponse
import logging as logger
from utils.RedisUtils import BloomFilter


class OperateConstant():
    DEL = "1"
    ADD = "0"
    MOD = "2"
    LIST = "3"
    BATCH_DEL = "4"
    RESUME = 3
    PAUSE = 4


class TemplateType():
    JobTemplate = "0"
    JobTemplateParam = "1"
    JobTemplateField = "2"


class ContentDetailTypeConstant():
    TASKJOB = "0"
    DBSOURCE = "1"
    TEMPLATE = "2"
    PROXY = "3"
    TASK_TIMER_JOB = "4"
    TASK_JOB_FIELD = '5'
    JOB_TEMPLATE_FIELD = '6'
    JOB_TEMPLATE_PARAM = '7'


class UploadType():
    Template = "1"
    Proxy = "2"


class TaskJobExecuteStatus():
    RUN = 0
    PAUSE = 1
    SAVE_CERT = 6


bloomFilter = None


@app.route("/saveTaskJobTemplate", methods=["POST", "GET"])
def saveTaskJobTemplate():
    params = loadParams()
    taskJobId = params.get("taskJobId")
    templates = params.get("templates")
    result = TaskService.taskJobReTemplate(taskJobId, templates)
    return parseResponse(0, {"result": result})


@app.route("/taskJobReTemplate", methods=["POST", "GET"])
def taskJobReTemplate():
    params = loadParams()
    taskJobId = params.get("taskJobId")
    result = TaskService.taskJobReTemplateDetail(taskJobId)
    return parseResponse(0, {"result": result})


@app.route("/loadTaskFieldByJobId", methods=['POST', 'GET'])
def loadTaskFieldByJobId():
    params = loadParams()
    taskJobId = params["id"]
    data = BaseDao.query(TaskJobReField, text('task_job_id="' + taskJobId + '"'), type=1)
    return parseResponse(0, {"data": data})


@app.route("/startCralwer", methods=['POST', 'GET'])
def startCralwer():
    params = loadParams()
    taskJobId = params["taskJobId"]
    taskJob = TaskJobDao.loadTaskById(taskJobId)
    # 清空redis中所保存的已爬取过得url表
    global bloomFilter
    if bloomFilter is None:
        bloomFilter = BloomFilter()
    bloomFilter.delete(taskJobId)
    if taskJob.taskJobTimerId and taskJob.taskJobTimerId != '0':
        tjs = TaskJobScheduler(taskJobId)
        taskTimer = TaskJobDao.loadTimerJob(taskJob.taskJobTimerId)
        tjs.addTask(taskTimer)
    else:
        startCrawlerByTaskJobId(taskJobId)

    return parseResponse(0)


@app.route("/pauseCralwer", methods=['POST', 'GET'])
def pauseCralwer():
    params = loadParams()
    taskJobId = params["taskJobId"]
    taskJob = TaskJobDao.loadTaskById(taskJobId)
    taskJobHistory = TaskJobDao.loadTaskJobHistoryFirstByTaskJobId(taskJobId)
    if taskJob and taskJobHistory and taskJob.status == TaskStatus.RUNNING:
        TaskJobDao.updateTaskJobStatus(taskJobId, TaskStatus.PAUSE)
        UrlDao.updateUrlStatusListByTaskJobHistoryId(taskJobHistory.id, status=UrlStatus.PAUSE)
        return parseResponse(0)
    else:
        return parseResponse(-1, {
            "status": taskJob.status
        })


@app.route("/resumeCralwer", methods=['POST', 'GET'])
def resumeCralwer():
    params = loadParams()
    taskJobId = params["taskJobId"]
    taskJob = TaskJobDao.loadTaskById(taskJobId)
    taskJobHistory = TaskJobDao.loadTaskJobHistoryFirstByTaskJobId(taskJobId)
    if taskJob and taskJobHistory and taskJob.status == TaskStatus.PAUSE:
        TaskJobDao.updateTaskJobStatus(taskJobId, TaskStatus.RUNNING)
        UrlDao.updateUrlStatusListByTaskJobHistoryId(taskJobHistory.id, oldStatus=UrlStatus.PAUSE)
        return parseResponse(0)
    else:
        return parseResponse(-1, {
            "status": taskJob.status
        })


@app.route("/restartCralwerForFailedUrlList", methods=['POST', 'GET'])
def restartCralwerForFailedUrlList():
    params = loadParams()
    taskJobId = params.get("taskJobId")
    failedUrlIdListStr = params.get("urlId")
    try:
        taskJob = TaskJobDao.loadTaskById(taskJobId)
        if taskJob:
            if failedUrlIdListStr:
                failedUrlIdList = [urlId for urlId in failedUrlIdListStr.split(",")]
                failedUrlStatusDictList = UrlDao.queryUrlStatusListByUrlIdList(failedUrlIdList)
            else:
                failedUrlStatusDictList = UrlDao.queryUrlStatusListByTaskJobId(taskJobId, UrlStatus.FAIL)
            if failedUrlStatusDictList and len(failedUrlStatusDictList):
                # 重新爬取时，将任务状态改为running继续爬取
                TaskJobDao.updateTaskJobStatus(taskJobId, TaskStatus.RUNNING)
                if TaskType.DEPTH == str(taskJob.type):
                    for failedUrlStatusDict in failedUrlStatusDictList:
                        taskJobDict = parseClassToDict(taskJob)
                        taskJobDict["url"] = failedUrlStatusDict.get("url")
                        taskJobDict["parentUrl"] = failedUrlStatusDict.get("parentUrl")
                        RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.DEPTH_SPIDER_REDIS_KEY),
                                         failedUrlStatusDict.get("taskJobHistoryId"))
                        RedisUtils.lpush(
                            ConfigUtils.getRedisPorperties(
                                KEYMAP.DEPTH_SPIDER_REDIS_KEY) + "_" + failedUrlStatusDict.get("taskJobHistoryId"),
                            stringify(taskJobDict))
                else:
                    jobTemplateDict = {}
                    for failedUrlStatusDict in failedUrlStatusDictList:
                        jobTemplateId = failedUrlStatusDict.get("jobTemplateId")
                        if jobTemplateDict.get(jobTemplateId):
                            jobTemplate = jobTemplateDict.get(jobTemplateId)
                        else:
                            jobTemplate = TemplateDao.queryJobTemplate(jobTemplateId)
                            jobTemplateDict[jobTemplateId] = jobTemplate
                        jobTemplateDict = parseClassToDict(jobTemplate)
                        jobTemplateDict["taskJobId"] = taskJobId
                        jobTemplateDict["taskJobHistoryId"] = failedUrlStatusDict.get("taskJobHistoryId")
                        jobTemplateDict["url"] = failedUrlStatusDict.get("url")
                        jobTemplateDict["extraData"] = {}
                        jobTemplateDict["urlListStatusId"] = failedUrlStatusDict.get("id")
                        RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.ASSIST_SPIDER_REDIS_KEY),
                                         failedUrlStatusDict.get("taskJobHistoryId"))
                        RedisUtils.lpush(
                            ConfigUtils.getRedisPorperties(
                                KEYMAP.ASSIST_SPIDER_REDIS_KEY) + "_" + failedUrlStatusDict.get("taskJobHistoryId"),
                            stringify(jobTemplateDict))
                return parseResponse(0)
            else:
                return parseResponse(-1, {
                    "desc": "no failed url"
                })
        else:
            return parseResponse(-1, {
                "desc": "no task job"
            })
    except Exception:
        logging.error(Exception)
        TaskJobDao.updateTaskJobStatus(taskJobId, TaskStatus.FAIL)


@app.route("/addJobTemplate", methods=['POST'])
def addJobTemplate():
    params = loadParams()
    jobTemplate = JobTemplate()
    for key in params:
        if hasattr(jobTemplate, key):
            setattr(jobTemplate, key, params[key])
    BaseDao.add(jobTemplate)
    return parseResponse(0)


@app.route("/addJobTemplateField", methods=['POST'])
def addJobTemplateField():
    params = loadParams()
    jobTemplateField = JobTemplateField()
    for key in params:
        if hasattr(jobTemplateField, key):
            setattr(jobTemplateField, key, params[key])
    BaseDao.add(jobTemplateField)
    return parseResponse(0)


@app.route("/createTable", methods=['POST'])
def createTable():
    params = loadParams()
    taskJob = parseJsonToClass(params, TaskJob)
    if (taskJob.id == None or taskJob.id == ""):
        return parseResponse(-1)
    DataBaseUtils.createTableByTaskJobId(taskJob.id)
    return parseResponse(0)


@app.route("/exportTemplate", methods=['GET'])
def exportTemplate():
    params = loadParams()
    taskJobId = params.get("taskJobId")
    return exportJobTemplate(taskJobId)


@app.route("/upload", methods=['POST'])
def upload():
    type = request.form["type"] or UploadType.Template
    html = None
    if type == UploadType.Template:
        file = parseFile();
        data = TemplateDao.parseTemplate(file)
        json = ResponseUtils.parseResponse(0, data, True)
    elif type == UploadType.Proxy:
        json = ResponseUtils.parseResponse(0, TaskService.parseProxyFile(), True)
    html = """<script>
               parent.loadJson&&parent.loadJson(%s);
           </script>""" % (json)
    return html


@app.route("/addJobTemplateParam", methods=['POST'])
def addJobTemplateParam():
    jobTemplateParam = parseResToClass(JobTemplateParam)
    BaseDao.add(jobTemplateParam)
    return parseResponse(0)


@app.route("/taskJobReField", methods=['POST'])
def taskJobReField():
    params = loadParams();
    taskJobId = params.get("taskJobId")
    jobTemplateId = params.get("jobTemplateId")
    fieldIds = params.get("fieldIds")
    type = params.get("type")
    if type == OperateConstant.ADD:
        TaskService.relationTaskJob(jobTemplateId, taskJobId, fieldIds)
    elif type == OperateConstant.DEL:
        TaskJobDao.delTaskJobReRelationByTaskJobId(taskJobId)
    return parseResponse(0)


@app.route("/proxyMgmt", methods=["POST"])
def proxyMgmt():
    params = loadParams()
    type = params.get("action")
    result = {}
    proxyInfo = RequestUtils.parseResToClass(ProxyInfo)
    if type == OperateConstant.ADD:
        result = ProxyDao.proxyAdd(proxyInfo)
    elif type == OperateConstant.MOD:
        result = ProxyDao.proxyModify(proxyInfo)
        # if result == 1:
        #     result = {"result":{"proxyInfo":proxyInfo}}
    elif type == OperateConstant.DEL:
        proxyInfo.delFlag = True
        result = ProxyDao.proxyMod(proxyInfo)
    return parseResponse(0, result)


@app.route("/getTemplateList", methods=['POST', 'GET'])
def getTemplateList():
    pass


@app.route("/getTaskList", methods=['POST', 'GET'])
def getTaskList():
    params = loadParams()
    pageNo = params.get("pageNo")
    pageSize = params.get("pageSize")
    userId = params.get("userId")
    searchParam = params.get("searchParam") or {}
    parentId = params.get("parentId")
    # searchMap=json.loads(searchParam) if searchParam!=None else {}
    orderBy = params.get("orderBy")
    name = searchParam.get("name")
    if searchParam.has_key("name"):
        del searchParam["name"]
        searchParam["name"] = {"value": "%" + name + "%", "condition": "like"}
    if pageNo == None:
        pageNo = 1

    if pageSize == None:
        pageSize = 20
    data = TaskJobDao.getTaskList(Page(int(pageNo), int(pageSize)), userId, searchParam, orderBy, parentId);
    count = data.get("count")
    return parseResponse(0, {"taskList": data.get("taskList"), "count": count,
                             "pageTotal": CalcUtils.divisionUp(count, int(pageSize))})


@app.route("/updateTaskStatus", methods=['POST', 'GET'])
def updateTaskStatus():
    params = loadParams()
    status = params.get("status")
    taskJobId = params.get("id")
    TaskJobDao.updateTaskJobStatus(taskJobId, status)
    return parseResponse(0)


@app.route("/contentDetail", methods=['POST', 'GET'])
def contentDetail():
    params = loadParams()
    id = str(params.get("id"))
    type = str(params.get("type"))
    result = None
    if type == ContentDetailTypeConstant.TASKJOB:
        result = TaskJobDao.contentDetail(id)
    elif type == ContentDetailTypeConstant.DBSOURCE:
        result = TaskJobDao.dbSourceDetail(id)
    elif type == ContentDetailTypeConstant.TEMPLATE:
        result = TemplateDao.templateDetail(id)
    elif type == ContentDetailTypeConstant.PROXY:
        result = ProxyDao.contentDetail(id)
    elif type == ContentDetailTypeConstant.TASK_TIMER_JOB:
        result = TaskTimerDao.contentDetail(id)
    elif type == ContentDetailTypeConstant.TASK_JOB_FIELD:
        result = {'result': TaskService.taskJobFieldByChoose(id)}
    elif type == ContentDetailTypeConstant.JOB_TEMPLATE_FIELD:
        result = {'jobTemlateField': TemplateDao.query(JobTemplateField, text('id="' + id + '"'), type=0)}
    elif type == ContentDetailTypeConstant.JOB_TEMPLATE_PARAM:
        result = {'jobTemlateParam': TemplateDao.query(JobTemplateParam, text('id="' + id + '"'), type=0)}
    return parseResponse(0, result)


@app.route("/taskMgmt", methods=['POST', 'GET'])
def taskMgmt():
    params = loadParams()
    action = params.get("action")
    name = params.get("name")
    id = params.get("id")
    taskJob = None
    if not TaskJobDao.validTaskJobName(name, id):
        return parseResponse(99999998)
    if action == OperateConstant.ADD:
        taskJob = RequestUtils.parseResToClass(TaskJob)
        TaskJobDao.addTaskJob(taskJob)
    elif action == OperateConstant.DEL:
        id = params.get("id")
        TaskJobDao.delTaskJob(id);
    elif action == OperateConstant.MOD:
        taskJob = RequestUtils.parseResToClass(TaskJob)
        TaskJobDao.updateTaskJob(taskJob)
    return parseResponse(0, {"result": taskJob})


@app.route("/taskCopy", methods=['POST'])
def taskCopy():
    params = loadParams()
    taskJobId = params.get("id")
    result = TaskJobDao.copyTask(taskJobId)
    return parseResponse(0, result);


@app.route("/addTaskJob", methods=['POST'])
def addTaskJob():
    params = loadParams()
    taskJob = TaskJob(id=uuid.uuid1())
    for key in params:
        if hasattr(taskJob, key):
            setattr(taskJob, key, params[key])
    createTime = taskJob.createTime
    tableName = taskJob.tableName
    taskJob.status = TaskStatus.WAITING
    if createTime == None:
        createTime = datetime.now();
    else:
        createTime = datetime.strptime(createTime, "%Y-%m-%d %H:%M").date()
    timeStr = createTime.strftime("%Y%m%d%H%M%S")
    if (tableName == None):
        tableName = "taskJob"
    taskJob.tableName = "%s_%s" % (tableName, timeStr)
    BaseDao.add(taskJob)
    return parseResponse(0)


# 添加数据链接
@app.route("/dbSourceMgnt", methods=['POST', "GET"])
def addDatabase():
    params = loadParams()
    action = params.get("action")
    if params.has_key('id'):
        dbsourceid = params.get("id")
        need_del_db_source_ids = dbsourceid.split(',')
    result = None
    dbSource = RequestUtils.parseResToClass(DbSource);
    if action == OperateConstant.ADD:
        result = TaskJobDao.addDbSource(dbSource)
    elif action == OperateConstant.DEL:
        in_using_dbsource_list = []
        if len(need_del_db_source_ids) > 0:
            for db_source_id in need_del_db_source_ids:
                if TaskJobDao.is_dbsource_in_using(db_source_id):
                    in_using_dbsource_list.append(db_source_id)
            # 如果数据源正在使用中，则不能删除
            if len(in_using_dbsource_list) > 0:
                return parseResponse(-1, {"ids": in_using_dbsource_list})
            else:
                TaskJobDao.delDbSource(need_del_db_source_ids)
        else:
            return parseResponse(-1)
    elif action == OperateConstant.MOD:
        result = TaskJobDao.updateDbSource(dbSource)
    return parseResponse(0, result)


@app.route("/taskJobTimerMgnt", methods=['POST'])
def taskJobTimerMgnt():
    params = loadParams()
    action = params.get("action")
    result = None
    taskJobTimer = RequestUtils.parseResToClass(TaskJobTimer);
    if action == OperateConstant.ADD:
        result = TaskJobDao.addTaskJobTimer(taskJobTimer)
    elif action == OperateConstant.DEL:
        result = TaskJobDao.delTaskJobTimer(taskJobTimer)
    elif action == OperateConstant.MOD:

        result = TaskJobDao.updateTaskJobTimer(taskJobTimer)
    return parseResponse(0, result)


@app.route("/queryTaskJobResult", methods=['POST'])
def queryTaskJobResult():
    params = loadParams()
    page = params.get("pageNo")
    pageCount = params.get("pageSize")
    taskJobId = params.get("taskJobId")
    # parentId=params.get("parentId")
    jobTemplateId = params.get("jobTemplateId")
    taskHistoryId = params.get("taskHistoryId")
    taskJob = TaskJobDao.loadTaskById(taskJobId)
    result = TemplateDao.queryTaskJobResult(taskJob, page, pageCount, jobTemplateId=jobTemplateId,
                                            taskHistoryId=taskHistoryId)
    return parseResponse(0, {"data": result})


@app.route("/exportResultExcel", methods=['POST'])
def exportResultExcel():
    params = loadParams()
    page = params.get("pageNo")
    pageCount = params.get("pageSize")
    jobTemplateId = params.get("jobTemplateId")
    # taskJob=TaskJobDao.loadTaskById(taskJobId)
    # result=TemplateDao.queryTaskJobResult(taskJob,page,pageCount)

    return parseResponse(0, {"download_url": TemplateDao.exportResult(jobTemplateId, page, pageCount)})


@app.route("/taskJobSchedulerMgnt", methods=['POST'])
def taskJobSchedulerMgnt():
    """
    周期任务的启停
    :return: 
    """
    params = loadParams()
    action = params.get("action")
    taskJobId = params["taskJobId"]
    taskJob = TaskJobDao.loadTaskById(taskJobId)
    if taskJob.taskJobTimerId:
        tjs = TaskJobScheduler(taskJobId)
        if action == OperateConstant.RESUME:
            TaskJobDao.updateTaskJobByTimer(taskJobId, TaskJobExecuteStatus.RUN)
            if tjs.get_job(taskJob.taskJobTimerId) is not None:
                tjs.resumTaskTimer(taskJob.taskJobTimerId)
            else:
                taskTimer = TaskJobDao.loadTimerJob(taskJob.taskJobTimerId)
                tjs.addTask(taskTimer)
        elif action == OperateConstant.PAUSE:
            TaskJobDao.updateTaskJobByTimer(taskJobId, TaskJobExecuteStatus.PAUSE)
            if tjs.get_job(taskJob.taskJobTimerId) is not None:
                tjs.stopTaskTimer(taskJob.taskJobTimerId)

    return parseResponse(0)


@app.route("/loadTemplateList", methods=["POST", "GET"])
def loadTemplateList():
    paramMap = loadParams()
    action = paramMap.get("action")
    parentId = paramMap.get("parentId")
    searchParam = paramMap.get("searchParam") or {}
    name = searchParam.get("name")
    if searchParam.has_key("name"):
        paramMap["name"] = {"value": "%" + name + "%", "condition": "like"}
    templateList = []
    if action == "0":
        templateList = TemplateDao.loadTemplate(paramMap=paramMap, parentId=parentId)
    elif action == "1":
        # taskJobId = paramMap.get("taskJobId")
        # templateList = TemplateDao.loadTemplateByTaskJobId(paramMap=paramMap)
        templateList = TemplateDao.query_template_list(paramMap=paramMap)
    return parseResponse(0, {"result": templateList})


@app.route("/templateMgmt", methods=["POST", "GET"])
def templateMgmt():
    paramMap = loadParams()
    action = str(paramMap.get("action"))
    operType = str(paramMap.get("type") if paramMap.get("actionType") == None  else paramMap.get("actionType"))
    if operType == TemplateType.JobTemplate:
        template = paramMap.get("template")
        objectInfo = RequestUtils.parseResToClass(JobTemplate, template)
    elif operType == TemplateType.JobTemplateParam:
        param = paramMap.get("param")
        objectInfo = RequestUtils.parseResToClass(JobTemplateParam, param)
    elif operType == TemplateType.JobTemplateField:
        field = paramMap.get("field")
        objectInfo = RequestUtils.parseResToClass(JobTemplateField, field)
    classType = type(objectInfo)
    result = None
    code = 0
    if action == OperateConstant.ADD:
        if isinstance(objectInfo, JobTemplate):  # and objectInfo.userLoginBehavior:
            userLoginBehavior = parseResToClass(UserLoginBehavior, objectInfo.userLoginBehavior)
            objectInfo.userLoginBehavior = userLoginBehavior
        if isinstance(objectInfo, JobTemplate):
            j = TemplateDao.query(classType, text('name="' + objectInfo.name + '"'), type=0)
            if j > 0:
                return parseResponse(600)
        TemplateDao.add(objectInfo)
        return parseResponse(0, {"jobTemplateId": objectInfo.id})
    elif action == OperateConstant.MOD:
        if isinstance(objectInfo, JobTemplate) and objectInfo.userLoginBehavior:
            userLoginBehavior = parseResToClass(UserLoginBehavior, objectInfo.userLoginBehavior)
            TemplateDao.updateByPrimaryKey(userLoginBehavior, UserLoginBehavior)
            objectInfo.userLoginBehaviorId = userLoginBehavior.id
        if hasattr(objectInfo, "userLoginBehavior"):
            delattr(objectInfo, 'userLoginBehavior')
        result = TemplateDao.updateByPrimaryKey(objectInfo, classType)
    elif action == OperateConstant.DEL:
        objectInfo.delFlag = 1
        if (classType == JobTemplate and TemplateDao.isBindTaskJob(objectInfo.id)):
            result = {"error": "模板被任务绑定不能删除"}
            code = -2
        if (classType == JobTemplate and TemplateDao.isHasChildTemplate(objectInfo.id) and TemplateDao.isBindTaskJob(
                objectInfo.id) == False):
            result = {"error": "有子模板没有删除,请先删除子模板"}
            code = -3
        else:
            result = TemplateDao.updateByPrimaryKey(objectInfo, classType)
    # elif action==OperateConstant.LIST:
    #     result = TemplateDao.updateByPrimaryKey(objectInfo,cls)
    #     pass
    return parseResponse(code, {"result": result})


@app.route('/contentTypeMgmt', methods=['POST', 'GET'])
def contentTypeMgmt():
    params = loadParams()
    id = params.get("id")
    if (params.get("type") == OperateConstant.DEL):
        ContentTypeDao.delContentType(id)
    elif params.get("type") == OperateConstant.MOD:
        ContentTypeDao.addContentType(RequestUtils.parseResToClass(ContentType, params))
    return parseResponse(0)


@app.route('/queryTemplistResultField', methods=['POST', 'GET'])
def queryTemplistResultField():
    params = loadParams()
    taskJobId = params.get("taskJobId")
    # parentId = params.get("parentId")
    # jobTemplateId = params.get("jobTemplateId")
    # taskJob = TaskJobDao.loadTaskById(taskJobId)
    result = TemplateDao.queryAllTempByTaskField(taskJobId)
    return parseResponse(0, {'data': result})


@app.route('/queryDbSourceList', methods=['POST', 'GET'])
def queryDbSourceList():
    try:
        params = loadParams();
        searchParam = params.get("searchParam") or {}
        dbname = searchParam.get("dbname")
        if searchParam.has_key("dbname"):
            del searchParam["dbname"]
            searchParam["dbname"] = {"value": "%" + dbname + "%", "condition": "like"}
        result = TaskJobDao.queryDbSourceList(searchParam)
        return parseResponse(0, {'data': result})
    except Exception, e:
        logger.exception("queryDbSourceList error")
        return parseResponse(-1)


@app.route('/totalCollectByTemplate', methods=['POST', 'GET'])
def collectListener():
    params = loadParams()
    result = TemplateDao.totalCollectByTemplate()
    return parseResponse(0, {'data': result})
    pass


@app.route('/totalCollectByType', methods=['POST', 'GET'])
def totalCollectByType():
    params = loadParams()
    result = TemplateDao.totalCollectByType()
    return parseResponse(0, {'data': result})
    pass


@app.route('/totalCollectListener', methods=['POST', 'GET'])
def totalCollectListener():
    params = loadParams()
    result = TemplateDao.totalCollectListenerDao()
    return parseResponse(0, {'data': result})
    pass


@app.route('/batchDel', methods=['POST', 'GET'])
def batch_del():
    """
    批量删除接口
    :return: 
    """
    paramMap = loadParams()
    if paramMap.has_key("ids") and paramMap.has_key("type"):
        ids = paramMap.get("ids")
        operType = str(paramMap.get("type"))
        idList = ids.split(",")
        classType = None
        if operType == TemplateType.JobTemplate:
            classType = JobTemplate
        elif operType == TemplateType.JobTemplateParam:
            classType = JobTemplateParam
        elif operType == TemplateType.JobTemplateField:
            classType = JobTemplateField
        bindList = []
        result = ""
        if idList and len(idList) > 0:
            for jobTemplateId in idList:
                if TemplateDao.isBindTaskJob(jobTemplateId):
                    template = TemplateDao.queryJobTemplate(jobTemplateId)
                    bindList.append(template)
                else:
                    result = TemplateDao.batch_del_templateId(jobTemplateId)
                    # noBindList.append(jobTemplateId)
            # result= TemplateDao.batch_del(classType,idList)
            if len(bindList) > 0:
                return parseResponse(-2, {'bindlist': bindList})
            else:
                return parseResponse(0, {'data': result})
        else:
            if (TemplateDao.isBindTaskJob(idList)):
                return parseResponse(-2)
            return parseResponse(-1)
    else:
        return parseResponse(-1)


@app.route('/queryUrlListByTaskJobId', methods=['POST', 'GET'])
def queryUrlListByTaskJobId():
    paramMap = loadParams()
    if paramMap.get("taskJobId"):
        status = paramMap.get("status")
        status = status if status and 0 <= int(status) < 6 else None
        urlStatusList = UrlDao.queryUrlStatusListByTaskJobId(paramMap.get("taskJobId"), status=status)
        urlStatusCountList = UrlDao.queryUrlStatusCountByTaskJobId(paramMap.get("taskJobId"))
        return parseResponse(0, {"count": urlStatusCountList, "dataList": urlStatusList})
    else:
        return parseResponse(-1)


@app.route('/queryUrlList', methods=['POST', 'GET'])
def queryUrlList():
    paramMap = loadParams()
    if paramMap.has_key("taskJobId"):
        taskJobId = paramMap.get("taskJobId")
        if taskJobId:
            taskJob = loadTaskById(taskJobId)
            urlStatusList = UrlDao.queryUrlStatusListForJson(taskJobId)
            return parseResponse(0,
                                 {'data': {"taskJobName": taskJob.name if taskJob else "", "urlList": urlStatusList}})
        else:
            return parseResponse(-1)
    else:
        return parseResponse(-1)


@app.route('/getPcWorkStatus')
def getPcWorkStatus():
    return parseResponse(0, {
        "status": PcWorkStatus.RUNNING,
        "errorList": [
            {
                "createDate": datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                "desc": "error 1"
            },
            {
                "createDate": datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                "desc": "error 2"
            },
            {
                "createDate": datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                "desc": "error 3"
            }
        ]
    })


from flask import g


def after_this_request(func):
    if not hasattr(g, 'call_after_request'):
        g.call_after_request = []
    g.call_after_request.append(func)
    return func


@app.after_request
def per_request_callbacks(response):
    for func in getattr(g, 'call_after_request', ()):
        response = func(response)
    if response.status_code != 200:
        logging.error(
            '******request %s failure(ErrorCode:%d)--reason:%s' % (request.url, response.status_code, response))
    return response


if __name__ == "__main__":
    pass
    # print 1/2
    # func=Session.query(TaskJob)
    # Session.query(TaskJob).join(func)
