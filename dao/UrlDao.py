# coding=utf-8

import logging

from sqlalchemy import func

from beans.UrlTable import UrlClazz, UrlStatus
from dao import BaseDao
from dao import TaskJobDao
from dao.BaseDao import add, with_session
from utils.JsonUtils import stringify, parseClassToDict

Session = BaseDao.Session


@with_session
def addUrl(urlClazz):
    return add(urlClazz)


@with_session
def updateUrl(urlClazz):
    try:
        Session.merge(urlClazz)
        Session.commit()
    except Exception:
        logging.error('updateUrl:error:%s' % (Exception,))
        Session.rollback()


@with_session
def delUrlById(urlId):
    tempData = {}
    tempData[UrlClazz.delFlag] = 1
    try:
        Session.query(UrlClazz).filter(UrlClazz.id == urlId).update(tempData)
        Session.commit()
    except Exception:
        logging.error('delUrlById:%s:error:%s' % (urlId, Exception))
        Session.rollback()


@with_session
def delUrlListByTaskJobId(taskJobId):
    tempData = {}
    tempData[UrlClazz.delFlag] = 1
    try:
        taskJobHistory = TaskJobDao.loadTaskJobHistoryFirstByTaskJobId(taskJobId)
        Session.query(UrlClazz).filter(taskJobHistory.id == UrlClazz.taskJobHistoryId).update(tempData)
        Session.commit()
    except Exception:
        logging.error('delUrlListByTaskJobId:%s:error:%s' % (taskJobId, Exception))
        Session.rollback()


@with_session
def queryUrlById(urlId):
    return Session.query(UrlClazz).filter(UrlClazz.id == urlId, UrlClazz.delFlag == False).first()


@with_session
def queryUrlStatusListByTaskJobId(taskJobId, status):
    taskJobHistory = TaskJobDao.loadTaskJobHistoryFirstByTaskJobId(taskJobId)
    if taskJobHistory:
        if status is None:
            urlStatusList = Session.query(UrlClazz).filter(UrlClazz.taskJobHistoryId == taskJobHistory.id,
                                                           UrlClazz.delFlag == False).all()
        else:
            urlStatusList = Session.query(UrlClazz).filter(UrlClazz.taskJobHistoryId == taskJobHistory.id,
                                                           UrlClazz.status == status,
                                                           UrlClazz.delFlag == False).all()
        tempUrlStatusList = []
        for urlStatus in urlStatusList:
            tempUrlStatusList.append(parseClassToDict(urlStatus))
        return tempUrlStatusList
    else:
        return []


@with_session
def queryUrlStatusCountByTaskJobId(taskJobId):
    resultList = []
    taskJobHistory = TaskJobDao.loadTaskJobHistoryFirstByTaskJobId(taskJobId)
    for status in (UrlStatus.WAITING, UrlStatus.RUNNING, UrlStatus.STOP, UrlStatus.FAIL, UrlStatus.SUCCESS,
                   UrlStatus.PAUSE):
        if taskJobHistory:
            resultList.append(
                Session.query(func.count(UrlClazz.id)).filter(UrlClazz.taskJobHistoryId == taskJobHistory.id,
                                                              UrlClazz.delFlag == False,
                                                              UrlClazz.status == status).scalar())
        else:
            resultList.append(0)
    return resultList


@with_session
def queryUrlStatusListByUrlIdList(urlIdList):
    tempUrlStatusList = []
    urlStatusList = Session.query(UrlClazz).filter(UrlClazz.id.in_(urlIdList), UrlClazz.delFlag == False).all()
    for urlStatus in urlStatusList:
        tempUrlStatusList.append(parseClassToDict(urlStatus))
    return tempUrlStatusList


def swapParseTree(taskJobId, sqlDataList, tempParentUrl="-1", tempJobTemplateParentId="-1"):
    treeList = []
    uselessList = []
    usefulList = []
    if tempJobTemplateParentId == "-1":
        uselessList = sqlDataList
        for sqlData in sqlDataList:
            if sqlData.parentUrl == tempParentUrl:
                usefulList.append(sqlData)
    else:
        for sqlData in sqlDataList:
            if sqlData.jobTemplateParentId != tempJobTemplateParentId:
                uselessList.append(sqlData)
            elif sqlData.parentUrl == tempParentUrl:
                usefulList.append(sqlData)
    if len(usefulList):
        for usefulData in usefulList:
            usefulDict = {
                "url": usefulData.url or "",
                "status": usefulData.status,
                "desc": usefulData.desc or "",
                "childNode": swapParseTree(taskJobId, uselessList, usefulData.url, usefulData.jobTemplateId)
            }
            treeList.append(usefulDict)
    return treeList


@with_session
def queryUrlStatusListForJson(taskJobId):
    taskJobHistory = TaskJobDao.loadTaskJobHistoryFirstByTaskJobId(taskJobId)
    if taskJobHistory:
        sqlDataList = Session.query(UrlClazz).filter(UrlClazz.taskJobHistoryId == taskJobHistory.id,
                                                     UrlClazz.delFlag == False).all()
        return swapParseTree(taskJobId, sqlDataList)
    else:
        return []


@with_session
def queryValueList():
    return Session.query(UrlClazz).all()


@with_session
def updateUrlStatus(urlId, status, desc=None):
    try:
        Session.query(UrlClazz).filter(UrlClazz.id == urlId).update({UrlClazz.status: status, UrlClazz.desc: desc})
        Session.commit()
    except Exception:
        logging.error('updateUrlStatus:%s_%s:error:%s' % (urlId, status, Exception))
        Session.rollback()


@with_session
def updateUrlStatusListByTaskJobHistoryId(taskJobHistoryId, oldStatus=UrlStatus.WAITING, status=UrlStatus.WAITING,
                                          desc=None):
    try:
        Session.query(UrlClazz).filter(UrlClazz.taskJobHistoryId == taskJobHistoryId,
                                       UrlClazz.status == oldStatus).update(
            {UrlClazz.status: status, UrlClazz.desc: desc})
        Session.commit()
    except Exception:
        logging.error('updateUrlStatusListByTaskJobHistoryId:%s_%s:error:%s' % (taskJobHistoryId, status, Exception))
        Session.rollback()


if __name__ == "__main__":
    print queryUrlStatusCountByTaskJobId("07cdf648-8c8f-11e7-b471-000c299438c6")
