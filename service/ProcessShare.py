#coding=utf-8
#Created by xutao on 2017-05-15.
# from multiprocessing.sharedctypes import RawArray
# RawArray.
import threading

import time

import logging

from beans.TaskTable import TaskJob, TaskStatus
from customize_app.publisher import WebSocket
from customize_app.publisher.beans.WebTable import JobStatus
from customize_app.publisher.dao import SearchTaskDao
from dao import BaseDao
from dao import LoggerDao
from dao import TaskJobDao
from utils import RedisUtils
from utils import TimeUtils

def closeFrame():
    time.sleep(120)
    WebSocket.sendMessage(
        "{'action': 'saveCert', 'returnCode': '0', 'returnMsg': 'SUCCESS'}")


# def run():
#     while (True):
#         # BaseDao.refresh()
#         logging.info("状态扫描" + TimeUtils.get_time_beforeNow(0, "%Y-%m-%d %H:%m"))
#         rungingTaskJobList = TaskJobDao.getRunningTaskJobList()
#         for taskJobRow in rungingTaskJobList:
#             taskJobHistoryId = taskJobRow["task_id_sequence"]
#             taskJobId = taskJobRow["ID"]
#             length = RedisUtils.llen("template:startId_" + taskJobHistoryId)
#             if (length <= 0):
#                 LoggerDao.addTaskJobLogger(TaskJob(id=taskJobId), LoggerDao.LoggerType.END,
#                                            taskJobHistoryId=taskJobHistoryId, status=TaskStatus.SUCCESS,
#                                            content=u"定向任务任务启动")
#                 # SearchTaskDao.updateSearckTask(taskJobId,JobStatus.TaskStatus)
#                 # SearchTaskDao.addGisInfoDetailField(taskJobId)
#                 TaskJobDao.updateTaskJobStatus(taskJobId, TaskStatus.SUCCESS)
#         time.sleep(60 * 10)
