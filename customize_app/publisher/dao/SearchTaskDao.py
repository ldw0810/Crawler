#coding=utf-8
#Created by xutao on 2017-05-09.
import random
import uuid
from datetime import datetime

from sqlalchemy import text

from beans.TaskTable import TaskJobHistory
from customize_app.publisher.beans import WebTable
from customize_app.publisher.beans.GisTable import GisInfoDetailField, AreaField, UrlReCityField
from customize_app.publisher.beans.WebTable import SearchTaskJob, JobStatus
from customize_app.publisher.dao.QueryGisTaskDetailDao import queryGisDetailBigOne, queryGisDetail
from dao import BaseDao
from dao import TemplateDao
from dao.BaseDao import Session, with_session
from utils import TimeUtils


@with_session
def getTaskList(page, userId=None, paramMap=None, orderBy=text('search_task_job.create_time desc'), parentId=None,status=None):
    queryParam = []
    # if parentId == None:
    #     queryParam.append(text("(ifnull(task_job.parent_id,'')='' or task_job.parent_id='-1')"))
    # else:
    #     queryParam.append(SearchTaskJob.childIds == parentId)
    if userId != None and userId != "-1" and userId != "":
        queryParam.append(SearchTaskJob.createUserId == userId)
    queryParam.append(SearchTaskJob.delFlag == False)
    queryParam = BaseDao.initialQueryParam(paramMap or {}, SearchTaskJob, queryParam)
    taskList = apply(Session.query(SearchTaskJob).filter, tuple(queryParam))
    if orderBy == None:
        orderBy = text('p_search_task_job.create_time desc')
    if status != None:
        taskList=taskList.filter(SearchTaskJob.status==status)
    if parentId == None:
        taskList = taskList.order_by(orderBy).offset(page.offset).limit(page.limit)
    taskList = taskList.all()
    count = apply(Session.query(SearchTaskJob).filter, tuple(queryParam)).count()
    return {"taskList":taskList,"count":count}
@with_session
def addTask(searchTaskJob):
    Session.add(searchTaskJob)
    Session.flush()
    Session.commit()
    return searchTaskJob
@with_session
def loadTaskById(id):
    return Session.query(SearchTaskJob).filter(SearchTaskJob.id==id).first()
@with_session
def SearchTaskByKeyField(key):
    return Session.query(SearchTaskJob).filter(SearchTaskJob.key.like ('%'+key+'%')).all()

# print loadTaskById("1")||||||| .r537
#     return Session.query(SearchTaskJob).filter(SearchTaskJob.id==id,SearchTaskJob.delFlag==False).first()
@with_session
def getRunnginTaskJob():
    sql=text("select * from p_search_task_Job,(select id as task_id_sequence " \
        " ,task_job_id,create_time history_create_time from task_job_history where del_flag=0  group by task_job_id order by create_time desc ) A " \
        "where A.task_job_id=p_search_task_job.id and p_search_task_job.status=1 and p_search_task_job.del_flag=0")
    return Session.execute(sql)
@with_session
def updateSearckTask(id,status=1):
    Session.query(SearchTaskJob).filter(SearchTaskJob.delFlag==False,SearchTaskJob.id==id).update({SearchTaskJob.status:status})
@with_session
def updateSearckTaskExecute(id,status=1):
    Session.query(SearchTaskJob).filter(SearchTaskJob.delFlag==False,SearchTaskJob.id==id).update({SearchTaskJob.executeStatus:status})
@with_session
def delSearchTask(id):
    ids=id.split(",")
    arr=[]
    for i in ids:
       arr.append("'"+i+"'")
    sql = 'update p_search_task_job set del_flag = 1 where id IN (%s) '% ",".join(arr)
    Session.execute(sql)
    Session.flush()
    Session.commit()
@with_session
def addGisInfoDetailField(taskJobId):
    gbi=Session.query(GisInfoDetailField).filter(GisInfoDetailField.taskJobId==taskJobId).first()
    if gbi!=None:
        return
    urlReCityFieldList=Session.query(UrlReCityField).all()
    searchTaskJob=loadTaskById(taskJobId)
    gisBigInfo = queryGisDetail(taskJobId)
    areaList=Session.query(AreaField).all()
    # jobTemplate=TemplateDao.queryTemplateByType(searchTaskJob.type)
    area=areaList[random.randint(0,len(areaList)-1)]
    urlReCity=urlReCityFieldList[random.randint(0,len(urlReCityFieldList)-1)]
    gisInfoDetailField=GisInfoDetailField()
    gisInfoDetailField.contentType=searchTaskJob.type
    gisInfoDetailField.createTtime=TimeUtils.get_time_beforeNow(0,'%Y-%m-%d %H:%M')
    gisInfoDetailField.detailAreaId=area.cityId
    gisInfoDetailField.detailUrl=urlReCity.url
    gisInfoDetailField.detailKv = searchTaskJob.key
    gisInfoDetailField.networkCnt =  random.randint(100,500)
    gisInfoDetailField.baiduSearchCnt =  random.randint(10000,50000)
    gisInfoDetailField.haosouSearchCnt =  random.randint(10000,50000)
    gisInfoDetailField.sougouSearchCnt =  random.randint(10000,50000)
    gisInfoDetailField.weixinSearchCnt = random.randint(10000,50000)
    gisInfoDetailField.allCnt = random.randint(1000,5000)
    gisInfoDetailField.suitability = random.randint(0,100)
    gisInfoDetailField.suitabilityRange = random.randint(0,100)
    gisInfoDetailField.genuineInfo = gisBigInfo.genuineInfo if gisBigInfo!=None else "人民的名义;李路;2017-05"
    gisInfoDetailField.piracyInfo = ''
    gisInfoDetailField.piracySource = random.randint(0,100)
    gisInfoDetailField.estimatedImpactCnt = random.randint(0,100)
    gisInfoDetailField.transmissionRate = random.randint(100,500)
    gisInfoDetailField.spreadScope = random.randint(100,500)
    gisInfoDetailField.resourceSize = random.randint(1000,10000)
    gisInfoDetailField.resourceInDate = datetime.now()
    gisInfoDetailField.taskJobId = searchTaskJob.id
    Session.add(gisInfoDetailField)
