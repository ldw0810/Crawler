#coding=utf-8
#Created by xutao on 2017-05-12.
from sqlalchemy import text

from beans.TemplateTable import JobTemplate, JobTemplateField
from customize_app.publisher.beans.WebTable import FieldWeight, SearchTaskJob
from customize_app.publisher.dao import SearchTaskDao
from dao import TaskJobDao
from dao.BaseDao import Session


def anayse(type,taskJobSequenceId):
    fieldWeightList=Session.query(FieldWeight).filter(FieldWeight.type==type).all()
    whileData=[]
    fieldNameList=[]
    for fieldWeight in fieldWeightList:
        weight=int(fieldWeight.weight)
        fieldNameEn=fieldWeight.fieldNameEn
        fieldNameList.append(fieldNameEn)
        whileData.append((fieldNameEn,weight or 0))
    filterSql=text("(SELECT parent_id FROM job_template where del_flag=0 GROUP BY parent_id)")
    # whiteJobTemplateList=Session.query(JobTemplate).filter(JobTemplate.id.notin_(filterSql),JobTemplate.delFlag==False,JobTemplate.objectType==1).all()
    blackJobTemplateList=Session.query(JobTemplate).filter(JobTemplate.jobTemplateType==type,JobTemplate.id.notin_(filterSql),JobTemplate.delFlag==False,JobTemplate.objectType!=1).all()
    # anaValue=[]
    jobTemplateInfo = []
    for jobTemplate in blackJobTemplateList:
        # anaMap={"jobTemplate":jobTemplate}
        tableName=jobTemplate.tableName
        jobTemplateId=jobTemplate.id
        # objectType=jobTemplate.objectType
        jobTemplateFieldList=Session.query(JobTemplateField).filter(JobTemplateField.jobTemplateId==jobTemplateId,JobTemplateField.delFlag==False).all()
        fieldList=[]
        for jobTemplateField in jobTemplateFieldList:
            fieldNameEn=jobTemplateField.fieldNameEn
            fieldList.append(fieldNameEn)
        dataSql=text("select %s from %s where task_job_id_sequence='%s'"%(",".join(fieldList),tableName,taskJobSequenceId))
        rs=Session.execute(dataSql).fetchall()
        blackValue = []
        for row in rs:
            map={}
            print row
            for name in fieldNameList:
                value=row[name] if row.has_key(name) else ""
                map[name]=value
            blackValue.append(map)
        jobTemplateInfo.append({"value":blackValue,"fieldName":fieldNameList,"jobTemplateInfo":jobTemplate})
    return {"value":jobTemplateInfo}

def queryData(id):
    taskJob=TaskJobDao.loadTaskJobHistoryFirstByTaskJobId(id)
    searchTaskJob=SearchTaskDao.loadTaskById(id)
    taskSequenceId=taskJob.id
    type=searchTaskJob.type
    return anayse(type,taskSequenceId)

if __name__=="__main__":
    print anayse(0,"6e6aa5ee-3941-11e7-a48a-e09467f6dff0")