#coding=utf-8
#Created by xutao on 2017-05-03.
import uuid
from datetime import datetime

from sqlalchemy import text

from beans.TaskTable import TaskJob, TaskJobReTemplate
from beans.TemplateTable import TaskJobReField, JobTemplateField, JobTemplate
from dao import BaseDao
from dao import ProxyDao
from dao import TaskJobDao
from dao import TemplateDao
from dao.BaseDao import Session, with_session
from utils import RequestUtils
#{"templates":[{"id":"123","fieldIds""123,2,3123,123"}],"id":"123"}
from utils.JsonUtils import stringify


@with_session
def taskJobReTemplate(taskJobId,templates):
    oldtaskjobtemp = Session.query(TaskJobReTemplate).filter(TaskJobReTemplate.taskJobId==taskJobId).all()
    for oldemp in oldtaskjobtemp:
        oldemp.delFlag = True
    for template in templates:
        taskJobReT=Session.query(TaskJobReTemplate).filter(TaskJobReTemplate.taskJobId==taskJobId,TaskJobReTemplate.jobTemplateId==template.get("id")).first()
        if taskJobReT==None:
            taskJobReTemplate=TaskJobReTemplate()
            taskJobReTemplate.jobTemplateId=template.get("id")
            taskJobReTemplate.fieldIds=template.get("fieldIds")
            taskJobReTemplate.taskJobId=taskJobId
            taskJobReTemplate.delFlag=False
            Session.add(taskJobReTemplate)
        else:
            taskJobReT.fieldIds=template.get("fieldIds")
            taskJobReT.delFlag = False
            BaseDao.updateByPrimary(taskJobReT,TaskJobReTemplate)
    Session.flush()
    Session.commit()
@with_session
def taskJobReTemplateDetail(taskJobId):
    # sql=text("(select job_template_id,field_ids from task_job_re_template where task_job_id='%s' and del_flag=0) A"%(taskJobId))
    taskJobReTemplateList=Session.query(TaskJobReTemplate).\
        filter(TaskJobReTemplate.taskJobId==taskJobId,TaskJobReTemplate.delFlag==False).all()
    job_template_idSql=text("(select job_template_id from task_job_re_template where task_job_id='%s' and del_flag=0)"%(taskJobId))
    jobTemplateList=Session.query(JobTemplate).filter(JobTemplate.delFlag==False,JobTemplate.id.in_(job_template_idSql)).all()
    fieldMap={}
    for taskJobReTemplate in taskJobReTemplateList:
        fieldMap[taskJobReTemplate.jobTemplateId]=taskJobReTemplate.fieldIds
    resultList=[]
    for jobTemplate in jobTemplateList:
        dataMap={}
        jobTemplateFieldList=Session.query(JobTemplateField).\
            filter(JobTemplateField.delFlag==False,JobTemplateField.jobTemplateId==jobTemplate.id).all()
        dataMap["jobTemplate"]=jobTemplate
        fields=fieldMap[jobTemplate.id]
        for jobTemplateField in jobTemplateFieldList:
            fieldArray = fields.split(",")
            if jobTemplateField.id in fieldArray or fields=="-1":
                setattr(jobTemplateField,"chooseFlag",True)
            else:
                setattr(jobTemplateField, "chooseFlag", True)
        dataMap["jobTemplateFieldList"]=jobTemplateFieldList
        resultList.append(dataMap)
    return resultList
# @with_session
def taskJobFieldByChoose(taskJobId):
    taskJobReTemplateList = Session.query(TaskJobReTemplate). \
        filter(TaskJobReTemplate.taskJobId == taskJobId, TaskJobReTemplate.delFlag == False).all()

    fieldlist = []
    if not taskJobReTemplateList:
        job_template_idSql = text(
            "(select job_template_id from task_job_re_field where task_job_id='%s' and del_flag=0)" % (taskJobId))
        jobTemplateList = Session.query(JobTemplate).filter(JobTemplate.delFlag == False,
                                                            JobTemplate.id.in_(job_template_idSql)).all()
        taskJobRefield = Session.query(TaskJobReField). \
            filter(TaskJobReField.taskJobId == taskJobId, TaskJobReField.delFlag == False).all()
        for refield in taskJobRefield:
            fields = Session.query(JobTemplateField). \
                filter(JobTemplateField.delFlag == False, JobTemplateField.id == refield.jobTemplateFieldId).one()
            fieldlist.append(fields)

    else:
        job_template_idSql = text(
            "(select job_template_id from task_job_re_template where task_job_id='%s' and del_flag=0)" % (taskJobId))
        jobTemplateList = Session.query(JobTemplate).filter(JobTemplate.delFlag == False,
                                                            JobTemplate.id.in_(job_template_idSql)).all()
        for taskJobReTemplate in taskJobReTemplateList:
                fieldArray = taskJobReTemplate.fieldIds.split(",")if taskJobReTemplate.fieldIds else []
                for fieldId in fieldArray:
                    fields = Session.query(JobTemplateField).\
                        filter(JobTemplateField.delFlag==False,JobTemplateField.id==fieldId).one()
                    fieldlist.append(fields)
    return {"jobTemplateFieldList":fieldlist,"jobTemplate":jobTemplateList}


@with_session
def relationTaskJob(jobTemplateId,taskJobId,fieldIds):
    TaskJobDao.delTaskJobReRelationByTaskJobId(taskJobId)
    if fieldIds!=None and str(fieldIds)=="-1":
        jobTemplateFieldList=TemplateDao.queryJobTemplateFieldByJobTemplateId(jobTemplateId)
        for field in jobTemplateFieldList:
            taskJobReField = TaskJobReField(id=uuid.uuid1())
            taskJobReField.jobTemplateId = jobTemplateId
            taskJobReField.taskJobId = taskJobId
            taskJobReField.delFlag = False
            taskJobReField.jobTemplateFieldId = field.id
            taskJobReField.createTime=datetime.now()
            Session.add(taskJobReField)
        return
    fieldList=fieldIds.split(",")
    for fieldId in fieldList:
        taskJobReField=TaskJobReField(id=uuid.uuid1())
        taskJobReField.jobTemplateId=jobTemplateId
        taskJobReField.taskJobId=taskJobId
        taskJobReField.delFlag=False
        taskJobReField.jobTemplateFieldId=fieldId
        taskJobReField.createTime=datetime.now()
        Session.add(taskJobReField)
    # TaskJobDao.updateTaskJob(TaskJob.id==taskJobId,{TaskJob.jobTemplateId:jobTemplateId})
    Session.query(TaskJob).filter(TaskJob.id==taskJobId).update({TaskJob.jobTemplateId:jobTemplateId})
    Session.flush()
    Session.commit()
def parseProxyFile():
    ipList=RequestUtils.parseProxyFile()
    return ProxyDao.addStaticProxyList(ipList);


def search(taskJobParam):
    Session.add(taskJobParam)
    return None

if __name__=="__main__":
    print stringify(taskJobReTemplateDetail("052d698f-3ee3-11e7-a155-e09467f6dff0"))