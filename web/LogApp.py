#coding=utf-8
#Created by xutao on 2017-05-25.
from dao import LoggerDao
from utils import ResponseUtils
from utils.RequestUtils import loadParams
from web import app


@app.route("/getTaskJobHistory",methods=["POST","GET"])
def getTaskJobHistory():
    params=loadParams()
    taskJobId=params.get("taskJobId")
    pageNo=params.get("pageNo") or 1
    pageSize=params.get("pageSize") or 10
    result=LoggerDao.getTaskJobHistory(taskJobId,pageNo,pageSize)
    return ResponseUtils.parseResponse(0,{"result":result})

@app.route("/getTaskJobLogs",methods=["POST","GET"])
def getTaskJobLogs():
    params=loadParams()
    taskJobHistoryId=params.get("taskJobHistoryId")
    pageNo=params.get("pageNo") or 1
    pageSize=params.get("pageSize") or 10
    result=LoggerDao.getLogList(taskJobHistoryId,pageNo,pageSize)
    return ResponseUtils.parseResponse(0,{"result":result})

