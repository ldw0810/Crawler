#coding=utf-8
import logging
import uuid
from datetime import datetime

from sqlalchemy import func
from sqlalchemy import text
from sqlalchemy.orm import Query
from beans.BaseBean import BaseBean, Base
from beans.TaskTable import TaskJob, TaskStatus, DbSource, TaskJobTimer, TaskJobDetail, ContentType, TaskJobParam, \
    TaskJobHistory, TaskJobHistoryType, TaskJobReTemplate
from beans.TemplateTable import TaskJobReField
from dao import BaseDao
from dao import LoggerDao
from dao import TemplateDao
from dao.BaseDao import query, count, Session, Page, with_session

#查找taskJob的字段
from utils import ClassCopy
from utils import RedisUtils
from utils.JsonUtils import stringify
def TaskJobExecuteStatus():
    RUN=0
    PAUSE=1
    SAVE_CERT=6
@with_session
def getRunningTaskJobList():
    sql = text("""SELECT 	* FROM 	task_job,( SELECT id AS task_id_sequence,task_job_id,create_time history_create_time
            FROM (select * from task_job_history order by create_time desc) A WHERE del_flag = 0 GROUP BY task_job_id ORDER BY
             			create_time DESC 	) A WHERE 	A.task_job_id = task_job.id AND task_job. STATUS = 1 AND task_job.del_flag = 0""")
    return Session.execute(sql)
def loadTaskJobReFieldList(taskJobId):
    return Session.query(TaskJobReField)\
        .filter(TaskJobReField.delFlag==False,TaskJobReField.taskJobId==taskJobId)\
        .all()
#r任务的拷贝
@with_session
def copyTask(taskJobId):
    taskJob=loadTaskById(taskJobId)
    taskJobReFieldList=loadTaskJobReFieldList(taskJobId)
    taskJobReTemplateList=TemplateDao.loadTaskJobReTemplate(taskJobId)
    taskJobNew=ClassCopy.copyToNewInstances(taskJob,TaskJob)
    id=uuid.uuid1()
    taskJobNew.id=id
    taskJobNew.createTime=datetime.now()
    taskJobNew.name=taskJob.name+"_副本"
    #状态置为0：未运行
    taskJobNew.status = 0
    Session.add(taskJobNew)
    flag=False
    for taskJobReField in taskJobReFieldList:
        taskJobReFieldNew=ClassCopy.copyToNewInstances(taskJobReField,TaskJobReField)
        taskJobReFieldNew.taskJobId=id
        taskJobReFieldNew.createTime=datetime.now()
        taskJobReFieldNew.id=uuid.uuid1()
        Session.add(taskJobReFieldNew)
    if(taskJobReTemplateList!=None):
        for taskJobReTemplate in taskJobReTemplateList:
            taskJobReTemplate = ClassCopy.copyToNewInstances(taskJobReTemplate, TaskJobReTemplate)
            taskJobReTemplate.taskJobId = id
            taskJobReTemplate.createTime = datetime.now()
            taskJobReTemplate.id = uuid.uuid1()
            Session.add(taskJobReTemplate)
    flag=True
    return {"flag":flag,"newTaskId":str(id)}
@with_session
def loadAllTaskFieldById(taskJobId):
    return query(TaskJobReField,text("task_job_id='"+taskJobId+"'and del_flag=0"),type=1)
@with_session
def addTaskJobHistroy(taskJobId,type):
    taskJobHistory=TaskJobHistory(id=uuid.uuid1(),taskJobId=taskJobId,createTime=datetime.now(),
                                  type=type,status=0)
    Session.add(taskJobHistory)
    return taskJobHistory
@with_session
def loadTaskJobHistoryFirstByTaskJobId(taskJobId):
    return Session.query(TaskJobHistory).\
        filter(TaskJobHistory.taskJobId==taskJobId,TaskJobHistory.delFlag==False).order_by(" create_time desc").first()
@with_session
def loadTaskJobHistoryById(id):
    return Session.query(TaskJobHistory).filter(TaskJobHistory.id==id,TaskJobHistory.delFlag==False).first()
@with_session
def loadChildByParentId(parentId):
    return Session.query(TaskJob).filter(TaskJob.parentId==parentId,TaskJob.delFlag==False).all()
#查找taskJob
@with_session
def loadTaskById(taskJobId):
    return Session.query(TaskJob).filter(TaskJob.id==taskJobId).first()
@with_session
def loadTimerJob(taskJobTimerId):
    return Session.query(TaskJobTimer).filter(TaskJobTimer.id==taskJobTimerId).first()
@with_session
def contentDetail(taskJobId):
    taskJob=loadTaskById(taskJobId)
    dbSourse=queryDbSource(taskJob.databaseId)
    #兄弟任务
    brotherList=loadChildByParentId(taskJob.parentId)
    #子任务
    childrenList=loadChildByParentId(taskJob.id)
    #父任务
    parent=loadTaskById(taskJob.parentId)
    timerJob=loadTimerJob(taskJob.taskJobTimerId)
    jobTemplate=TemplateDao.queryJobTemplate(taskJob.jobTemplateId)
    jobTemplateList=TemplateDao.queryJobTemplateFieldByJobTemplateId(taskJob.jobTemplateId)
    taskReFieldList=loadAllTaskFieldById(taskJob.id)
    chooseMap={}
    for taskJobReField in taskReFieldList:
        chooseMap[taskJobReField.jobTemplateFieldId]=True
    for jobTemplateField in jobTemplateList:
        jobTemplateField.chooseFlag=chooseMap.get(jobTemplateField.id) or False
    #日志接口（列表，下载接口）
    #模板勾选字段
    return {"result":TaskJobDetail(dbSourse,taskJob,brotherList,parent,timerJob,jobTemplate,jobTemplateList,taskReFieldList,childrenList)}
@with_session
def dbSourceDetail(dbSourceId):
    return {"result":Session.query(DbSource).filter(DbSource.id==dbSourceId).first()}
#获取任务列表
@with_session
def getTaskList(page=Page(1,10),userId=None,paramMap=None,orderBy=text('task_job.create_time desc'),parentId=None):

    # sql = None
    # if(userId==None):
    #     sql=text(" del_flag=0")
    # else:
    #     sql=text("create_user_id='" + userId + "' and del_flag=0")
    queryParam=[]
    if parentId==None:
        queryParam.append(text("(ifnull(task_job.parent_id,'')='' or task_job.parent_id='-1')"))
    else:
        queryParam.append(TaskJob.parentId==parentId)
    if userId!=None and userId!="-1" and userId!="":
        queryParam.append(TaskJob.createUserId == userId)
    queryParam.append(TaskJob.delFlag == False)
    queryParam=BaseDao.initialQueryParam(paramMap or {},TaskJob,queryParam)
    taskList=apply(Session.query(TaskJob).filter,tuple(queryParam))
    if orderBy==None:
        orderBy=text('task_job.create_time desc')
    if parentId==None:
        taskList=taskList.order_by(orderBy).offset(page.offset).limit(page.limit)
    taskList=taskList.all()
    count=apply(Session.query(TaskJob).filter,tuple(queryParam)).count()
    return {"taskList":taskList,"count":count}
@with_session
def countObj(userId,clazz,paramMap):
    queryParam = []
    queryParam.append(text("(ifnull(parent_id,'')='' or parent_id='-1')"))
    if userId!=None and userId!="-1" and userId!="":
        queryParam.append(TaskJob.createUserId == userId)
    queryParam.append(clazz.delFlag == False)
    queryParam = BaseDao.initialQueryParam(paramMap, clazz, queryParam)
    return apply(Session.query(clazz.id).filter,tuple(queryParam)).count()
def updateTaskJobStatus(taskId,status):
    try:
        Session.query(TaskJob).filter(TaskJob.id==taskId).update({TaskJob.status:status,TaskJob.lastExecuteTime:datetime.now()})
        Session.commit()
    except Exception:
        logging.error('updateTaskJobStatus:%s:error:%s' % (taskId, status))
        Session.rollback()
    try:
        RedisUtils.hsetUrlRedisStatus(RedisUtils.prefix + taskId, status)
    except Exception:
        pass
@with_session
def updateTaskJob(param,up):
    Session.query(TaskJob).filter(param).update(up)
#删除任务
@with_session
def delTaskJob(taskId):
    taskIds = taskId.split(",")
    for i in range(len(taskIds)):
        LoggerDao.addTaskJobLogger(TaskJob(id=taskIds[i]),LoggerDao.LoggerType.DEL,content=u"删除任务")
    Session.query(TaskJob).filter(TaskJob.id.in_(tuple(taskIds))).update({TaskJob.delFlag:True}, synchronize_session='fetch')
@with_session
def queryTaskJobParam(taskJobId):
    return Session.query(TaskJobParam).filter(TaskJobParam.taskJobId==taskJobId,TaskJobParam.delFlag==False).all()
@with_session
def updateTaskJobByTimer(taskJobId,status):
    Session.query(TaskJob).filter(TaskJob.id==taskJobId).update({TaskJob.executeStatus:status})
    return

def validTaskJobName(name,id):
    if name==None:
        return True
    queryParam=[TaskJob.name == name, TaskJob.delFlag == False]
    if id!=None:
        queryParam.append(TaskJob.id!=id)
    count=apply(Session.query(TaskJob).filter,queryParam).count()
    return True if count<=0 else False
#添加任务
@with_session
def addTaskJob(taskJob):
    taskJob.id=uuid.uuid1()
    createTime = taskJob.createTime
    tableName = taskJob.tableName
    taskJob.status = TaskStatus.WAITING
    if createTime == None:
        createTime = datetime.now();
    elif(type(createTime)=="string"):
        createTime = datetime.strptime(createTime, "%Y-%m-%d %H:%M").date()
    timeStr = createTime.strftime("%Y%m%d%H%M%S")
    if (tableName == None):
        tableName = "taskJob"
    taskJob.tableName = "%s_%s" % (tableName, timeStr)
    LoggerDao.addTaskJobLogger(taskJob, LoggerDao.LoggerType.ADD,
                               content=u"创建任务", status=taskJob.status)
    BaseDao.add(taskJob)
#更新任务
@with_session
def updateTaskJob(taskJob):
    taskJobDb=Session.query(TaskJob).filter(TaskJob.id==taskJob.id).first()
    LoggerDao.addTaskJobLogger(taskJobDb, LoggerDao.LoggerType.MOD,
                               content=u"更新任务", status=taskJobDb.status)
    return BaseDao.updateByPrimary(taskJob,TaskJob)
@with_session
def queryDbSource(dbSourceId):
    return Session.query(DbSource).filter(DbSource.id==dbSourceId).first()
#增加数据库链接
@with_session
def addDbSource(dbSource):
    id=uuid.uuid1()
    dbSource.id=id
    dbSource.createTime=datetime.now()
    dbSource.delFlag=False
    return {"result":{"code":BaseDao.add(dbSource),"databaseId":str(id),"object":dbSource}}
#增加数据库链接
@with_session
def updateDbSource(dbSource):
    return {"result":{"code":BaseDao.updateByPrimary(dbSource,DbSource),"databaseId":str(dbSource.id),"object":dbSource}}
@with_session
def delDbSource(db_source_ids):
    sql = None
    if len(db_source_ids)==1:
        sql = "update db_source set del_flag=1 where id='%s'" %db_source_ids[0]
    elif len(db_source_ids)>1:
        temp_ids=[]
        for id in db_source_ids:
            temp_ids.append(id.encode(encoding='utf-8'))
        sql = "update db_source set del_flag=1 where id IN%s" %str(tuple(temp_ids))
    BaseDao.execute(sql)
def is_dbsource_in_using(dbsource_id):
    """
    判断数据源是否正在使用中
    :param dbsource_id: 
    :return: 
    """
    try:
        s = """select * from db_source d where d.ID IN (select j.database_id from job_template as j where j.del_flag=0 and j.database_id="%s" UNION SELECT t.database_id from task_job t where t.del_flag=0 and t.database_id="%s")""" %(dbsource_id,dbsource_id)
        result = BaseDao.execute(s)
    except Exception,e:
        logging.exception(str(e))
        return False
    return result.rowcount>0
#增加时间配置
@with_session
def addTaskJobTimer(taskJobTimer):
    id=uuid.uuid1()
    taskJobTimer.id=id
    taskJobTimer.createTime=datetime.now()
    taskJobTimer.delFlag=False
    return {"result":BaseDao.add(taskJobTimer),"timerJobTimerId":str(id)}
#增加时间配置
@with_session
def updateTaskJobTimer(taskJobTimer):
    return {"result":BaseDao.updateByPrimary(taskJobTimer,TaskJobTimer)}
@with_session
def delTaskJobTimer(taskJobTimer):
    taskJobTimer.delFlag=True
    return {"result":BaseDao.updateByPrimary(taskJobTimer,TaskJobTimer)}
@with_session
def delTaskJobReRelationByTaskJobId(taskJobId):
    return Session.query(TaskJobReField).filter(TaskJobReField.taskJobId==taskJobId)\
        .update({TaskJobReField.delFlag:True})
@with_session
def delTaskJobReFieldById(id):
    return Session.query(TaskJobReField).filter(TaskJobReField.id == id) \
        .update({TaskJobReField.delFlag: True})

@with_session
def queryDbSourceList(paramMap):
    queryParam=[]
    queryParam.append(DbSource.delFlag==0)
    queryParam = BaseDao.initialQueryParam(paramMap or {}, DbSource, queryParam)
    dbSourceList = apply(Session.query(DbSource).filter, tuple(queryParam))
    sortlist = dbSourceList.order_by(DbSource.createTime).all()
    sortlist.reverse()
    newSortDbSourcelist = sortlist
    return newSortDbSourcelist

class tes1():
    a=1
    def __eq__(self, other):
        print "123"
    def __cmp__(self, other):
        print "and"
class A:
    def __init__(self):
        pass
class B(A):
    pass
if __name__=="__main__":
    # taskJob= TaskJob(id="2",delFlag=True)
    # taskJob= contentDetail("1")
    # print getTaskList(Page(),None,{"delFlag":"1","id":"1"},"create_time")
    # func = Session.query(TaskJob)
    # sbq=Session.query(TaskJob,func.count("1").label("count")).group_by("parent_id").subquery()
    # taskJob=loadTaskById(1)#Session.query(TaskJob).join(ContentType).all()#getTaskList(Page())
    #,sbq.c.count).outerjoin(sbq,sbq.c.id==TaskJob.id).first()
    #.query("(select count(1) from task_job where Tparent_id=task_job.parent_id) as countFlag ")
    # print getTaskList()
    # queryParam = BaseDao.initialQueryParam({"delFlag":"1","id":"1"}, TaskJob)
    # print type(Session.query(TaskJob).filter())
    # for key in queryParam.keys():
        # yield (queryParam.get(key))

    # print is_dbsource_in_using('39f5d488-4bf3-11e7-ac41-000c299438c6')
    ids = [u'39f5d488-4bf3-11e7-ac41-000c299438c6']
    delDbSource(ids)