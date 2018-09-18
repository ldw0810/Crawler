# -*- coding: utf-8 -*-
import random
from datetime import datetime
import uuid
from time import sleep

from sqlalchemy import text

from beans.SeriesEntity import JobTemplateSerialize
from beans.TaskTable import TaskJob, TaskJobHistoryType,TaskJobReTemplate, DbSource, TaskJobHistory,ContentType
from beans.TemplateTable import TaskJobReField, JobTemplateField, JobTemplate, JobTemplateParam, JobTemplateType,CrawlerDataListener
from dao import BaseDao
from utils.ExportExcelUtils import export
from dao.BaseDao import query, querySql, add, Session, with_session, Page
# print query(TaskJobReField, text('task_job_id="1"'), type=1)
#查询字段列表
from utils import ClassCopy
from utils.JsonUtils import stringify
from utils.ResponseUtils import parseResponse
import json
@with_session
def loadTemplateByTaskJobId(paramMap):
    taskJobId=paramMap.get("taskJobId")
    del paramMap["taskJobId"]
    inSql=text("select task_job_re_template.job_template_id from task_job_re_template " \
          "where task_job_re_template.task_job_id='%s' group by task_job_re_template.task_job_id "%(taskJobId))
    paramMap = dict({"id": {"value": inSql, "condition": "in_"}}.items()+paramMap.items())
    return loadTemplate(None,paramMap)
@with_session
def loadTaskJobReTemplate(taskJobId):
    return Session.query(TaskJobReTemplate).\
        filter(TaskJobReTemplate.delFlag==False,TaskJobReTemplate.taskJobId==taskJobId).all();
@with_session
def loadTemplate(page=Page(1,10),paramMap={},userId=None,orderBy=text(" job_template.create_time desc "),parentId=None):
    queryParam = []
    # if parentId == None:
    #     queryParam.append(text("(ifnull(job_template.parent_id,'')='' or job_template.parent_id='-1')"))
    # else:
    #     queryParam.append(JobTemplate.parentId == parentId)
    if parentId is not None:
        queryParam.append(JobTemplate.parentId == parentId)
    if userId != None and userId != "-1" and userId != "":
        queryParam.append(TaskJob.createUserId == userId)
    if paramMap and paramMap.has_key("pageNo") and paramMap.has_key("pageSize"):
        page = Page(paramMap["pageNo"],paramMap["pageSize"])
    queryParam.append(JobTemplate.delFlag == False)
    queryParam = BaseDao.initialQueryParam(paramMap or {}, JobTemplate, queryParam)
    filterQuery=Session.query(JobTemplate).filter
    taskList = apply(filterQuery, tuple(queryParam))
    if orderBy == None:
        orderBy = text('task_job.create_time desc')
    if (parentId == None or parentId == '-1') and page!=None:
        taskList = taskList.order_by(orderBy).offset(page.offset).limit(page.limit)
    taskList = taskList.all()
    count = apply(filterQuery, tuple(queryParam)).count()
    # if paramMap.has_key('action'):
    #     action = paramMap['action']
    #     if action == '1':
    #         jobtemp = taskList[0]
    #         jobtemplist = queryAllTempByTaskJob(jobtemp)#递归查询子模板
    #         if jobtemplist:
    #             taskList.extend(jobtemplist)
    #         count = len(taskList)
    return {"jobTemplateList": taskList, "count": count}
@with_session
def queryAllTempByTaskJob(jobtemp,array=[]):
    jobtemplist = Session.query(JobTemplate).filter(JobTemplate.parentId == jobtemp.id).all()
    for tempj in jobtemplist:
        if  tempj not in array:
            array.append(tempj)
    for temp in jobtemplist:
        tempArray = array
        templist = queryAllTempByTaskJob(temp,array)
        if not templist:
           break
    return array

@with_session
def queryFieldByTaskJobId(taskJobId):
    # sql = """ select * from job_template_field where id in
    #       (select job_tempalte_field_id from task_job_re_field where task_job_id=%s group by job_template_id)"""%(taskJobId) ;
    sql = """ del_flag=0 and id in
              (select job_tempalte_field_id from task_job_re_field where task_job_id='%s' and del_flag=0 group by job_tempalte_field_id)""" % (
    taskJobId);
    return query(JobTemplateField,text(sql),type=1)
#查询任务信息
@with_session
def queryJobTemplate(taskJobId):
    # sql = """ select * from job_template_field where id in
    #       (select job_tempalte_field_id from task_job_re_field where task_job_id=%s group by job_template_id)"""%(taskJobId) ;
    sql = """ id=(select job_template_id from task_job where id='%s' and del_flag=0) and del_flag=0"""% (taskJobId);
    return query(JobTemplate,text(sql),type=0)
@with_session
def queryJobParam(taskJobId):
    # sql = """ select * from job_t   emplate_field where id in
    #       (select job_tempalte_field_id from task_job_re_field where task_job_id=%s group by job_template_id)"""%(taskJobId) ;
    sql = """ id in (select job_template_param_id from task_job_re_template_param where id='%s'
                    and del_flag=0) and del_flag=0 group by job_template_param_id"""% (taskJobId);
    return query(JobTemplateParam,text(sql),type=0)
@with_session
def isBindTaskJob(jobTemplateId):
    resultList=[]
    temp = queryParentTemplateByChildTemplateId(jobTemplateId)
    if(type(jobTemplateId)==list):
        resultList = Session.query(TaskJobReTemplate).filter(TaskJobReTemplate.delFlag == False,
                                                             TaskJobReTemplate.jobTemplateId.in_(jobTemplateId)).all()
    else:
        if temp :
            jobTemplateId = temp.id
        resultList=Session.query(TaskJobReTemplate).filter(TaskJobReTemplate.delFlag==False,TaskJobReTemplate.jobTemplateId==jobTemplateId).all()
    return True if len(resultList)>0 else False
@with_session
def isHasChildTemplate(jobTemplateId):
    if (type(jobTemplateId) == list):
        resultList = Session.query(JobTemplate).filter(JobTemplate.parentId==jobTemplateId.in_(jobTemplateId),JobTemplate.delFlag == False).all()
    else:
        resultList = Session.query(JobTemplate).filter(JobTemplate.parentId == jobTemplateId,
                                                       JobTemplate.delFlag == False).all()
    return True if len(resultList) > 0 else False

#根据模板id获取到一级模板
def queryParentTemplateByChildTemplateId(templateId):
    temp = Session.query(JobTemplate).filter(JobTemplate.id == templateId,
                                                       JobTemplate.delFlag == False).first()
    if temp.parentId != '-1':
        parentTemplate = Session.query(JobTemplate).filter(JobTemplate.id == temp.parentId,
                                                           JobTemplate.delFlag == False).first()
        if parentTemplate.parentId != '-1':
           return queryParentTemplateByChildTemplateId(parentTemplate.parentId)
        else:
            return parentTemplate
    else:
        return temp


#查询子任务
@with_session
def childTaskJobByParentId(parentId):
    sql=text("""parent_id='%s' and del_flag=0"""%(parentId))
    object = query(TaskJob,sql,type=1)
    return object
@with_session
def querTaskJob(taskJobId):
    return query(TaskJob,text("id='%s' and del_flag=0"%(taskJobId)),type=0)
@with_session
def querTaskJobParam(taskJobId):
    return query(TaskJob,text("id='%s' and del_flag=0"%(taskJobId)),type=0)
@with_session
def queryJobTemplate(jobTemplateId):
    return query(JobTemplate,text("id='%s' and del_flag=0"%(jobTemplateId)),type=0)
@with_session
def queryJobTemplateListByParentId(jobTemplateId):
    sql = text("find_in_set('%s',job_template.parent_id)!=0" % (jobTemplateId))
    return Session.query(JobTemplate). \
        filter(sql, JobTemplate.delFlag == False).all()
@with_session
def queryJobTemplateParamByJobTemplateId(jobTemplateId):
    return query(JobTemplateParam,text("job_template_id='%s' and del_flag=0"%(jobTemplateId)),type=1)
@with_session
def queryJobTemplateParamByJobTemplateIdType(jobTemplateId):
    return query(JobTemplateParam,text("job_template_id='%s' and del_flag=0 and type=0"%(jobTemplateId)),type=1)
@with_session
def queryJobTemplateFieldAndJobTemplateByJobTemplateId(jobTemplateId):
    fields=query(JobTemplateField,text("job_template_id='%s' and del_flag=0"%(jobTemplateId)),type=1)
    params = query(JobTemplateParam,text("job_template_id='%s' and del_flag=0"%(jobTemplateId)),type=1)
    template=queryJobTemplate(jobTemplateId)
    return {"jobTemplate":template,"jobTemplateFieldList":fields,"jobTemplateParamList":params}
@with_session
def queryJobTemplateFieldAndJobTemplateByJobId(jobId):
    taskjob = querTaskJob(jobId)
    templateReField = Session.query(TaskJobReField).filter(TaskJobReField.jobTemplateId == taskjob.jobTemplateId).all()
    objectlist = []
    for field in templateReField:
        object_field = query(JobTemplateField,text("id ='%s' and del_flag=0"%(field.jobTemplateFieldId)),type=1)
        objectlist.append(object_field)
    if objectlist:
        return {"result": objectlist}
    else:
        return {"result": queryJobTemplateFieldAndJobTemplateByJobTemplateId(taskjob.jobTemplateId)}
#模板字段
@with_session
def queryJobTemplateFieldByJobTemplateId(jobTemplateId):
    fields=query(JobTemplateField,text("job_template_id='%s' and del_flag=0"%(jobTemplateId)),type=1)
    return fields
@with_session
def templateDetail(jobTemplateId):
    return {"result":queryJobTemplateFieldAndJobTemplateByJobTemplateId(jobTemplateId)}
@with_session
def addJobTemplateField(jobTemplateField):
    return add(jobTemplateField)
@with_session
def addTaskJob(taskJob):
    return add(taskJob)
@with_session
def addJobTemplate(jobTemplate):
    return add(jobTemplate)
@with_session
def queryTemplateByType(type):
    jobTemplateList=Session.query(JobTemplate).filter(JobTemplate.jobTemplateType==type).all()
    jobTemplate=jobTemplateList[random.randint(0,len(jobTemplateList))]
    return jobTemplate
@with_session
def parseTemplate(jsonTemplateSerialize):
    jobTemplateId=uuid.uuid1()
    jobTemplate=jsonTemplateSerialize.jobTemplate;
    if jobTemplate==None:
        return {"error":""}
    newJobTemplate=ClassCopy.copyToNewInstances(jobTemplate,JobTemplate)
    newJobTemplate.id=jobTemplateId
    Session.add(newJobTemplate)
    jobTemplateFieldList=jsonTemplateSerialize.jobTemplateFieldList
    newjobTemplateFieldList=[]
    newJobTemplateParamList=[]
    if jobTemplateFieldList!=None and len(jobTemplateFieldList)!=0:
        for jobTemplateField in jobTemplateFieldList:
            newJobTemplateField=ClassCopy.copyToNewInstances(jobTemplateField, JobTemplateField)
            newJobTemplateField.id = uuid.uuid1()
            newJobTemplateField.jobTemplateId=jobTemplateId
            newjobTemplateFieldList.append(newJobTemplateField)
            Session.add(newJobTemplateField)
    jobTemplateParamList = jsonTemplateSerialize.jobTemplateParamList
    if jobTemplateParamList != None and len(jobTemplateParamList) != 0:
        for jobTemplateParam in jobTemplateParamList:
            newJobTemplateParam = ClassCopy.copyToNewInstances(jobTemplateParam, JobTemplateParam)
            newJobTemplateParam.id = uuid.uuid1()
            newJobTemplateParam.jobTemplateId = jobTemplateId
            newJobTemplateParamList.append(newJobTemplateParam)
            Session.add(newJobTemplateParam)
    return {"result":JobTemplateSerialize(newJobTemplate,newjobTemplateFieldList,newJobTemplateParamList)}
@with_session
def queryTaskJobResult(taskJob,page=1,pageCount=10,jobTemplateId=None,parentId=None,taskHistoryId=None):
    from utils.DBClient import DbClient
    import json
    jobTemplate=None
    result=None
    count=None
    tableTitle=None
    db=DbClient()
    page=page or 1
    pageCount=pageCount or 10
    databaseId=None
    taskJobId=None
    if taskJob!=None:
        slavedb=db.getConnection(taskJob.databaseId)
        databaseId=taskJob.databaseId
        taskJobId = taskJob.id
    if jobTemplateId!=None:
        jobTemplate = Session.query(JobTemplate).filter(JobTemplate.id == jobTemplateId).first()
        slavedb = db.getConnection(jobTemplate.databaseId)
        databaseId=jobTemplate,databaseId
    if (taskJob!=None and taskJob.type==TaskJobHistoryType.BATCH) or jobTemplate!=None:
        taskJob=jobTemplate
    #     result = slavedb.query_table_pages(jobTemplate.tableName, page, pageCount,parentId)
    #     count = slavedb.query_count(jobTemplate.tableName,parentId)
    #     tableTitle = slavedb.queryTableTitle(taskJob.tableName)
    #     return
    # else:
    if taskHistoryId==None:
        taskJobHistory=Session.query(TaskJobHistory).filter(TaskJobHistory.taskJobId==taskJobId,TaskJobHistory.delFlag==False).\
            order_by(text(" create_time desc ")).first()
        taskHistoryId=taskJobHistory and taskJobHistory.id
    result = slavedb.query_table_pages(taskJob.tableName, page, pageCount,parentId,taskHistoryId or "none")
    count=slavedb.query_count(taskJob.tableName,parentId,taskHistoryId or 'none')
    tableTitle=slavedb.queryTableTitle(taskJob.tableName,slavedb and slavedb.db_config and slavedb.db_config.get("db"))
    return {'result':json.loads(result),'title':json.loads(tableTitle),'count':json.loads(count)}
@with_session
def queryAllTempByTaskField(taskJobId):

    taskJobReTemplate = Session.query(TaskJobReTemplate).filter(TaskJobReTemplate.taskJobId == taskJobId).first()
    result = None
    if taskJobReTemplate is not None:
        jobTemplate = Session.query(JobTemplate).filter(JobTemplate.id == taskJobReTemplate.jobTemplateId).first()
        jobTemplate1 = Session.query(JobTemplate).filter(JobTemplate.parentId == jobTemplate.id).first()
        sql = "select w1.wechatImage,w1.detailURL,w3.title,w3.time,w3.organization from %s w1 join %s w3 on w1.id=w3.parent_id" % (jobTemplate.tableName,jobTemplate1.tableName)
        result = BaseDao.execute(sql)
        if result and len(result.cursor._rows) > 0:
            result= result.cursor._rows
    return {'result':result,'count':[[len(result)]]}


@with_session
def exportResult(jobTemplateId,page=1,pageCount=10):
    from utils.DBClient import DbClient
    import json
    jobTemplate = Session.query(JobTemplate).filter(JobTemplate.id == jobTemplateId).first()
    db=DbClient()
    slavedb=db.getConnection(jobTemplate.databaseId)
    result=json.loads(slavedb.query_table_pages(jobTemplate.tableName,page,pageCount))
    title=json.loads(slavedb.queryTableTitle(jobTemplate.tableName,db.dbparms["dbname"]))
    return export(jobTemplate.tableName,result,title)
    # 'result':json.loads(slavedb.query_table_pages(taskJob.tableName,page,pageCount)),
    # 'title':json.loads(slavedb.queryTableTitle(taskJob.tableName)),
    # 'count':json.loads(slavedb.query_count(taskJob.tableName))
@with_session
def add(info):
    setattr(info, "createTime", datetime.now())
    return BaseDao.add(info)
@with_session
def updateByPrimaryKey(info,cls):
    return BaseDao.updateByPrimary(info,cls)
@with_session
def delByPrimaryKey(info,clazz):
    setattr(info,"delFlag",True)
    return BaseDao.updateByPrimary(info,clazz)

def query_template_list(paramMap):
    if paramMap and paramMap.has_key("pageNo") and paramMap.has_key("pageSize"):
        page = Page(int(paramMap["pageNo"]), int(paramMap["pageSize"]))
    taskJobId = paramMap['taskJobId']
    taskJobReTemplateList = Session.query(TaskJobReTemplate).filter(TaskJobReTemplate.taskJobId == taskJobId,
                                                                    TaskJobReTemplate.delFlag == 0).all()
    jobTemplateList = []
    if taskJobReTemplateList is not None and len(taskJobReTemplateList) > 0:
        for reTemplate in taskJobReTemplateList:
            rootJobTemplateId = reTemplate.jobTemplateId
            rootJobTemplate = Session.query(JobTemplate).filter(JobTemplate.id == rootJobTemplateId).first()
            if rootJobTemplate is not None and rootJobTemplate.delFlag == False:
                jobTemplateList.append(rootJobTemplate)
                get_child_templates(rootJobTemplate.id, jobTemplateList)
    if page.offset + page.limit >= len(jobTemplateList):
        templateList = jobTemplateList[page.offset:]
    else:
        templateList = jobTemplateList[page.offset:page.offset + page.limit]
    count = len(jobTemplateList)
    return {"jobTemplateList": templateList, "count": count}

def get_child_templates(parentId,resultList):
    childTemplateList = Session.query(JobTemplate).filter(JobTemplate.parentId == parentId,JobTemplate.delFlag==False).all()
    if childTemplateList is not None and len(childTemplateList)>0:
        resultList.extend(childTemplateList)
        for jobTemplate in childTemplateList:
                get_child_templates(jobTemplate.id,resultList)
        pass

def queryTableCount(jobTemplate):
    from utils.DBClient import DbClient
    db = DbClient()
    slavedb = db.getConnection(jobTemplate.databaseId)
    rs=json.loads(slavedb.query_collect_index(db.dbparms['dbname'],jobTemplate.tableName))
    if rs is not None and len(rs) > 0:
        return sum(rs[0])
    else:
        return 0
    pass
@with_session
def totalCollectByTemplate():
    TemplateList= Session.query(JobTemplate).all()
    # [{'name':'购物','pers':'','num':''}]
    result=[]
    totleData=0
    for jobTemplate in TemplateList:
        if jobTemplate.parentId == '-1':
            child_temp_list=[]
            count=0
            get_child_templates(jobTemplate.id,child_temp_list)
            for childTemp in child_temp_list:
                count=count+queryTableCount(childTemp)
            count=count+queryTableCount(jobTemplate)
            totleData+=count
            result.append({'name':jobTemplate.name,'count':count})
    for i in range(0, len(result)):
        p=result[i]["count"]/float(totleData)
        result[i]["percent"] =float('%.2f'% p )
       
    result.sort(lambda x, y: cmp(x['count'], y['count']))
    result = sorted(result, key=lambda x: x['count'])
    if len(result)>5:
        return [result[-1],result[-2],result[-3],result[-4],result[-5],result[-6]]
    else:
        return result

@with_session
def totalCollectByTemplateType():
    result=[]
    contentTypeList=Session.query(ContentType).all()
    totleData = 0
    for contentType in contentTypeList:
        count = 0
        TemplateList=Session.query(JobTemplate).filter(JobTemplate.jobTemplateType == contentType.id).all()
        for jobTemplate in TemplateList:
            count += queryTableCount(jobTemplate)
        totleData += count
        result.append({'name':contentType.name,'count':count})
    for i in range(0, len(result)):
        result[i]["percent"] = round(result[i]["count"] / totleData, 2)
    return result
@with_session
def  totalCollectListenerDao():
    result_0=totalCollectByTemplateType()
    result_1 = totalCollectByTemplate()
    result_2=Session.query(CrawlerDataListener).order_by(CrawlerDataListener.createTime.desc()).limit(24).all()
    return result_0,result_1,result_2

@with_session
def batch_del(cls,ids):
    result = Session.query(cls).filter(cls.id.in_(ids)).update({cls.delFlag:1},synchronize_session=False )
@with_session
def batch_del_templateId(templateId):
    #删除该模板下的所有子模板
    paretTemplate = Session.query(JobTemplate).filter(JobTemplate.id == templateId).first()
    paretTemplate.delFlag = True
    childlist=[]
    get_child_templates(templateId,childlist)
    for childTemp in childlist:
        childTemp.delFlag=True

if __name__=="__main__":
    s1=totalCollectByTemplate()
    s2=totalCollectByTemplateType()
    rs=totalCollectListenerDao()
    pass
    # print
    # jobTemplate=JobTemplate(id=uuid.uuid1())
    # BaseDao.add(jobTemplate)
    # print
    # print queryJobTemplate("1")
    # print datetime.strptime("2017-04-14 17:56","%Y-%m-%d %H:%M").date()
    # taskJob=childTaskJobByParentId("8e2bfa4f-24ca-11e7-8b9a-e09467f6dff1")
    # # url=taskJob.url
    # print taskJob.url
    # sleep(10)
    # # url="test"
    # taskJob=None
    # taskJob=childTaskJobByParentId("8e2bfa4f-24ca-11e7-8b9a-e09467f6dff1")
    # print taskJob.url
    # print query_template_list('f332a22e-4eb4-11e7-97ae-000c29d41136')
    # jobt =  queryJobTemplate("01cd3891-3464-11e7-8d06-e09467f6dff0")
    # print jobt
    # from beans.TemplateTable import UserLoginBehavior
    # from utils.RequestUtils import loadParams, parseFile, parseResToClass
    # from utils.ResponseUtils import parseResponse,stringify
    # from utils import RequestUtils
    # from utils import ResponseUtils
    # import json

    # jobT = JobTemplate(id="ypctest5",name="ypctest5",url="www.ypc.test5")
    # userL = UserLoginBehavior()
    # userL.userId="root7"
    # userL.passWord="7777"
    # jobT.userLoginBehavior= userL
    # s = ResponseUtils.stringify(jobT)
    # jStr = json.loads(s)
    # objectInfo = RequestUtils.parseResToClass(JobTemplate,jStr)
    # if isinstance(objectInfo, JobTemplate) and objectInfo.userLoginBehavior:
    #     userLoginBehavior = parseResToClass(UserLoginBehavior, objectInfo.userLoginBehavior)
    #     objectInfo.userLoginBehavior = userLoginBehavior
    # result = add(objectInfo)
    # print result

    # jobT = JobTemplate(id="ypctest5", name="ypctest6", url="www.ypc.test6")
    # jobT.userLoginBehaviorId="123"
    # updateByPrimaryKey(jobT,type(jobT)