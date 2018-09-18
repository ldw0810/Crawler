#coding=utf-8
#Created by xutao on 2017-05-04.
from beans.TaskTable import TaskJobParam
from service import TaskService
from utils import RequestUtils
from web import app


@app.route("/search",methods=["post"])
def searchApp():
    params=RequestUtils.loadParams()
    taskJobParam=RequestUtils.parseResToClass(params,TaskJobParam)
    TaskService.search(taskJobParam)

