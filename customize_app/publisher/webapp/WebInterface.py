#coding=utf-8
#Created by xutao on 2017-05-08.
from datetime import datetime

from beans.TaskTable import TaskJobParam
from customize_app.publisher import WebSocket
from customize_app.publisher.beans.WebTable import SearchTaskJob, JobStatus
from customize_app.publisher.dao import SearchTaskDao,JudicatureDao,TortTotalDao
from customize_app.publisher.service import AnaylyzeService
from customize_app.publisher.service import SearchService
from dao.BaseDao import Page, Session
from service import CrawlerService
from service import TaskService
from utils import CalcUtils
from utils import RequestUtils
from utils.RequestUtils import loadParams
from utils.ResponseUtils import parseResponse
from web import app

@app.route("/publisher/detailScreen",methods=["GET","POST"])
def detailScreen():
    params=loadParams()
    id=params.get("id")
    message="{'taskJobId':'"+str(id)+"','action':'2'}"
    message=message.encode("utf-8")
    WebSocket.sendMessage(message)
    return parseResponse(0)

@app.route("/publisher/screen",methods=["GET","POST"])
def sendSocketMsg():
    params=loadParams()
    id=params.get("id")
    type=params.get("type")
    message="{'taskJobId':'"+str(id)+"','action':0,'type':'"+type+"'}"
    message=message.encode("utf-8")
    WebSocket.sendMessage(message)
    return parseResponse(0)

@app.route("/publisher/queryData",methods=["GET","POST"])
def queryData():
    params = loadParams()
    taskJobId = params.get("id")
    result=AnaylyzeService.queryData(taskJobId)
    return parseResponse(0,{"result":result})
@app.route("/publisher/search",methods=["GET","POST"])
def search():
    params=loadParams()
    keyWord = params.get("keyWord")
    taskJobId=params.get("id")
    SearchService.startCrawlerByTaskJobId(taskJobId);
    return parseResponse(0)
@app.route("/publisher/delsearch",methods=["GET","POST"])
def delSearch():
    params=loadParams()
    id = params.get("id")
    SearchTaskDao.delSearchTask(id);
    return parseResponse(0)
@app.route("/publisher/searchByKey",methods=["GET","POST"])
def searchByKeyVal():
    params=loadParams()
    key = params.get("key")
    data = SearchTaskDao.SearchTaskByKeyField(key);
    return parseResponse(0, {"data": data})
@app.route("/publisher/taskMgmt",methods=["GET","POST"])
def taskMgmtSearch():
    params=loadParams()
    searchTaskJob=RequestUtils.parseResToClass(SearchTaskJob,params)
    searchTaskJob.createTime=datetime.now()
    searchTaskJob.status=JobStatus.WAIT_RUNNING
    SearchTaskDao.addTask(searchTaskJob)
    return parseResponse(0,{"result":searchTaskJob})
@app.route("/publisher/getTaskList",methods=["GET","POST"])
def getTaskListSearch():
    params = loadParams()
    pageNo = params.get("pageNo")
    pageSize = params.get("pageSize")
    userId = params.get("userId")
    searchParam = params.get("searchParam") or {}
    parentId = params.get("parentId")
    orderBy = params.get("orderBy")
    name = searchParam.get("name")
    status = params.get("status")
    if searchParam.has_key("name"):
        del searchParam["name"]
    searchParam["like('name')"] = name
    if pageNo == None:
        pageNo = 1
    if pageSize == None or pageSize > 100:
        pageSize = 20
    data = SearchTaskDao.getTaskList(Page(pageNo, pageSize), userId, searchParam, orderBy, parentId,status);
    count = data.get("count")
    return parseResponse(0, {"taskList": data.get("taskList"), "count": count,
                             "pageTotal": CalcUtils.divisionUp(count, pageSize)})

@app.route("/publisher/updateExecuteStatus", methods=["GET", "POST"])
def updateExecuteStatus():
    params = loadParams()
    id = params.get("id")
    sql = 'update p_search_task_job set execute_status=1,status = 6 where id = "%s" AND DEL_FLAG = 0' % id
    # sql = "select * from S_total_info where DATE_FORMAT(CREATE_TIME,'%Y-%m-%d') = %s" % timestr
    Session.execute(sql)
    return parseResponse(0)

