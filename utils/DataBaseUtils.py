#coding=utf-8
#Created by xutao on 2017-04-15.
import pickle

from flask import make_response
from beans import SeriesEntity
from beans.TaskTable import TaskJob
from beans.TemplateTable import JobTemplateParam, JobTemplateField, JobTemplate
from dao import TemplateDao
from dao.BaseDao import query, execute, Session
from dao.TaskJobDao import loadAllTaskFieldById, loadTaskById
from dao.TemplateDao import queryFieldByTaskJobId, queryJobTemplate, queryJobTemplateFieldByJobTemplateId
from utils import ClassCopy
from utils import DesUtils


def createTable(taskJob,taskJobReField):
    tableName=taskJob.tableName

def createTable(taskJobId):
    taskJob= loadTaskById(taskJobId)
    tableName=taskJob.tableName
    jobTemplateFieldList=queryFieldByTaskJobId(taskJobId)
    if(jobTemplateFieldList==None or len(jobTemplateFieldList)==0):
        return
    sql = "create table "+tableName+"("
    for jobTemplateField in jobTemplateFieldList:
        dataLength = jobTemplateField.dataLength
        dataType = jobTemplateField.dataType
        fieldNameEn = jobTemplateField.fieldNameEn
        sql = sql+"`"+fieldNameEn+"` " +dataType+" "
        if dataLength!=None and dataLength>0:
            sql = sql+"("+str(dataLength)+"),"
    sql = sql[0:sql.rfind(",")]+");"
    return execute(sql)

def createTableByTaskJobId(taskJobId):
    taskJob= loadTaskById(taskJobId)
    tableName=taskJob.tableName
    jobTemplateFieldList=queryFieldByTaskJobId(taskJobId)
    if(jobTemplateFieldList==None or len(jobTemplateFieldList)==0):
        return
    fieldList=[]
    for jobTemplateField in jobTemplateFieldList:
        dataLength = jobTemplateField.dataLength
        dataType = jobTemplateField.dataType
        fieldNameEn = jobTemplateField.fieldNameEn
        if dataLength != None and dataLength > 0:
             fieldList.append("`%s` %s(%s)"%(fieldNameEn,dataType,dataLength))
        else:
            fieldList.append("`%s` %s" % (fieldNameEn, dataType))
    fieldList.append("`id` varchar(50)")
    fieldList.append("`task_job_create_time` datetime")
    fieldList.append("`task_job_del_flag` tinyint(1)")
    return execute("create table %s(%s)"%(tableName,",".join(fieldList)))
def exportJobTemplate(jobTemplateId):
    jobTemplate = queryJobTemplate(jobTemplateId)
    newJobTemplate=ClassCopy.copyToNewInstances(jobTemplate,JobTemplate)
    jobTemplateParamList = TemplateDao.queryJobTemplateParamByJobTemplateId(jobTemplateId)
    newJobTemplateParamList=[]
    if jobTemplateParamList!=None and len(jobTemplateParamList)>0:
        for jobTemplateParam in jobTemplateParamList:
            newJobTemplateParamList.append(ClassCopy.copyToNewInstances(jobTemplateParam,JobTemplateParam))
    newJobTemplateFieldList = []
    jobTemplateFieldList = TemplateDao.queryJobTemplateFieldByJobTemplateId(jobTemplateId) #(jobTemplateId)J
    if jobTemplateFieldList != None and len(jobTemplateFieldList) > 0:
        for jobTemplateField in jobTemplateFieldList:
            newJobTemplateFieldList.append(ClassCopy.copyToNewInstances(jobTemplateField,JobTemplateField))
    # jobTemplateSerialize = SeriesEntity.JobTemplateSerialize(newJobTemplate, newJobTemplateFieldList,newJobTemplateFieldList)
    jobTemplateSerialize = SeriesEntity.JobTemplateSerialize(newJobTemplate, newJobTemplateFieldList,newJobTemplateParamList)
    content=jobTemplateSerialize.serialize()
    response = make_response(content)
    response.headers["Content-Disposition"] = "attachment; filename=template%s.data"%(jobTemplateId)
    return response
def importJobTemplate(jobTemplateId):
    jobTemplate = queryJobTemplate(jobTemplateId)
    jobTemplateFieldList = TemplateDao.queryJobTemplateFieldByJobTemplateId(jobTemplateId)
    jobTemplateSerialize = SeriesEntity.JobTemplateSerialize(jobTemplate, jobTemplateFieldList)
    response = make_response(jobTemplateSerialize)
    response.headers["Content-Disposition"] = "attachment; filename=template%s.data"%(jobTemplateId)
    return response
def exportJobTemplateText(jobTemplateId):
    jobTemplate=queryJobTemplate(jobTemplateId)
    jobTemplateFieldList=TemplateDao.queryJobTemplateFieldByJobTemplateId(jobTemplateId)
    jobTemplateSerialize=SeriesEntity.JobTemplateSerialize(jobTemplate,jobTemplateFieldList)
    print jobTemplateSerialize.serialize()
    print SeriesEntity.JobTemplateSerialize.deSerialize(jobTemplateSerialize.serialize())#.jobTemplate.id
    return;
if __name__=="__main__":
    # print ",".join(["123","12312","123123"]);
    exportJobTemplate("f125688f-20f0-11e7-9acb-da017ca21966")