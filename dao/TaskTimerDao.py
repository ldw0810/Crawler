#coding=utf-8
#Created by xutao on 2017-05-05.
from beans.TaskTable import TaskJobTimer
from dao import BaseDao
from dao.BaseDao import Session, with_session


@with_session
def contentDetail(taskJobTimerId):
    taskJobTimerId=str(taskJobTimerId)
    return {"result":Session.query(TaskJobTimer).filter(TaskJobTimer.id==taskJobTimerId,TaskJobTimer.delFlag==False).first()}
@with_session
def update(taskJobTimerId):
    return BaseDao.updateByPrimary(taskJobTimerId,TaskJobTimer)